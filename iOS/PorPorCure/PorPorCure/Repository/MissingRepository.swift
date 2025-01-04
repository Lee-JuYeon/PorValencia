//
//  MissingRepository.swift
//  PorPorCure
//
//  Created by Jupond on 12/24/24.
//

import Foundation

#if canImport(Combine)
import Combine
#endif

#if canImport(RxSwift)
import RxSwift
#endif

import FirebaseCore
import FirebaseDatabase

class MissingRepository: MissingProtocol {

    private let database = Database.database().reference()
    private let missingPath : String = "missing"
    
    private func fetchListFromFirebase(completion: @escaping (Result<[MissingModel], Error>) -> Void) {
        self.database.child(self.missingPath).observeSingleEvent(of: .value) { (snapshot: DataSnapshot) in
            // 1. 스냅샷 전체 로깅
            print("전체 스냅샷: \(snapshot.value ?? "없음")")
            
            guard let value = snapshot.value as? [String: [String: Any]] else {
                print("데이터 형식 오류: \(type(of: snapshot.value))")
                completion(.failure(NSError(domain: "Invalid data format", code: -1, userInfo: nil)))
                return
            }
            
            let dateFormatter = ISO8601DateFormatter()
            let list = value.compactMap { (key, dict) -> MissingModel? in
                // 2. 각 항목의 데이터 로깅
                print("현재 처리 중인 항목: \(dict)")
                
                // 필드별로 안전하게 추출
                guard
                    let character = dict["character"] as? String,
                    let dateStr = dict["date"] as? String,
                    let gender = GenderType.fromServerValue(dict["gender"] as? String ?? "MALE"),
                    let imageURL = dict["imageURL"] as? String,
                    let lat = dict["lat"] as? Double,
                    let lon = dict["lon"] as? Double,
                    let missingState = MissingType.fromServerValue(dict["missingState"] as? String ?? "MISSING"),
                    let name = dict["name"] as? String,
                    let requestFamilyUID = dict["requestFamilyUID"] as? String,
                    let zone = dict["zone"] as? String else {
                    
                    // 3. 매핑 실패 시 어떤 필드가 문제인지 로깅
                    print("매핑 실패한 데이터: \(dict)")
                    return nil
                }

                let date = dateFormatter.date(from: dateStr) ?? Date()

                return MissingModel(
                    uid: key,
                    requestFamilyUID: requestFamilyUID,
                    missingState: missingState,
                    name: name,
                    date: date,
                    zone: zone,
                    imageURL: imageURL,
                    gender: gender,
                    character: character,
                    lon: lon,
                    lat: lat
                )
            }
            
            // 4. 최종 모델 개수 로깅
            print("변환된 모델 개수: \(list.count)")
            completion(.success(list))
        }
    }
    
    func loadList(completion: @escaping (Result<[MissingModel], Error>) -> Void) {
        if #available(iOS 13.0, *) {
            let publisher = Future<[MissingModel], Error> { promise in
                self.fetchListFromFirebase { result in
                    switch result {
                    case .success(let list):
                        promise(.success(list))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
            }
            .eraseToAnyPublisher()
            
            // Combine 구독
            let cancellable = publisher.sink(receiveCompletion: { combineCompletion in
                switch combineCompletion {
                case .failure(let error):
                    completion(.failure(error))
                case .finished:
                    break
                }
            }, receiveValue: { models in
                completion(.success(models))
            })
            
            // 주의: Combine은 사용 후 구독을 취소해야 합니다.
            _ = cancellable
        } else {
            // RxSwift
            let observable = Observable<[MissingModel]>.create { observer in
                self.fetchListFromFirebase { result in
                    switch result {
                    case .success(let list):
                        observer.onNext(list)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
                return Disposables.create()
            }
            
            // RxSwift 구독
            let disposable = observable.subscribe(
                onNext: { models in
                    completion(.success(models))
                },
                onError: { error in
                    completion(.failure(error))
                }
            )
            
            // 주의: RxSwift는 사용 후 구독을 해제해야 합니다.
            _ = disposable
        }
    }
    
   
}
