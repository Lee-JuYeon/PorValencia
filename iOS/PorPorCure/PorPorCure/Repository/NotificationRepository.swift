//
//  NotificationRepository.swift
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

class NotificationRepository: NotificationProtocol {

    private let database = Database.database().reference()
    private let missingPath : String = "missing"
    private let notificationPath : String = "notification"
   
    private func fetchListFromFirebase(completion: @escaping (Result<[NotificationModel], Error>) -> Void) {
        self.database.child(self.notificationPath).observeSingleEvent(of: .value) { (snapshot: DataSnapshot) in
            // 1. 스냅샷 전체 로깅
            print("전체 스냅샷: \(snapshot.value ?? "없음")")
            
            guard let value = snapshot.value as? [String: [String: Any]] else {
                print("데이터 형식 오류: \(type(of: snapshot.value))")
                completion(.failure(NSError(domain: "Invalid data format", code: -1, userInfo: nil)))
                return
            }
            
            let list = value.compactMap { (key, dict) -> NotificationModel? in
                // 2. 각 항목의 데이터 로깅
                print("현재 처리 중인 항목: \(dict)")
                
                // 필드별로 안전하게 추출
                guard
                    let title = dict["title"] as? String,
                    let dateStr = dict["date"] as? String,
                    let content = dict["content"] as? String
                else {
                    print("매핑 실패한 데이터: \(dict)")
                    return nil
                }
                
                let dateFormatter = ISO8601DateFormatter()
                let date = dateFormatter.date(from: dateStr) ?? Date()
                
                return NotificationModel(
                    uid: key,
                    title: title,
                    text: content,
                    date: date
                )
            }
            
            // 4. 최종 모델 개수 로깅
            print("변환된 모델 개수: \(list.count)")
            completion(.success(list))
        }
    }
    
    func loadList(completion: @escaping (Result<[NotificationModel], Error>) -> Void) {
        if #available(iOS 13.0, *) {
            let publisher = Future<[NotificationModel], Error> { promise in
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
            let observable = Observable<[NotificationModel]>.create { observer in
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
