//
//  MissingProtocol.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/13/24.
//

import Combine
import Foundation
import FirebaseCore
import FirebaseDatabase


class MissingRepository : MissingProtocol {
   
    
    private let database = Database.database().reference()
    private let missingPath : String = "missing"
    private let notificationPath : String = "notification"
    
    func loadNotificationModels() -> AnyPublisher<[NotificationMoel], any Error> {
        Future<[NotificationMoel], Error> { promise in
            self.database.child(self.notificationPath).observeSingleEvent(of: .value) { (snapshot: DataSnapshot) in
                   // 1. 스냅샷 전체 로깅
                   print("전체 스냅샷: \(snapshot.value ?? "없음")")

                   guard let value = snapshot.value as? [String: [String: Any]] else {
                       print("데이터 형식 오류: \(type(of: snapshot.value))")
                       promise(.failure(NSError(domain: "Invalid data format", code: -1, userInfo: nil)))
                       return
                   }


                   let model = value.compactMap { (key, dict) -> NotificationMoel? in
                       // 2. 각 항목의 데이터 로깅
                       print("현재 처리 중인 항목: \(dict)")

                       // 필드별로 안전하게 추출
                       guard
                           let title = dict["title"] as? String,
                           let dateStr = dict["date"] as? String,
                           let content = dict["content"] as? String else {
                           
                           // 3. 매핑 실패 시 어떤 필드가 문제인지 로깅
                           print("매핑 실패한 데이터: \(dict)")
                           return nil
                       }

                       let dateFormatter = ISO8601DateFormatter()
                       let date = dateFormatter.date(from: dateStr) ?? Date()

                       return NotificationMoel(
                            uid: key,
                            title: title,
                            text: content,
                            date: date
                       )
                   }
                   
                   // 4. 최종 모델 개수 로깅
                   print("변환된 모델 개수: \(model.count)")
                   promise(.success(model))
               }
           }
           .eraseToAnyPublisher()
    }
    
    
    func loadMissingModels() -> AnyPublisher<[MissingModel], Error> {
        Future<[MissingModel], Error> { promise in
            self.database.child(self.missingPath).observeSingleEvent(of: .value) { (snapshot: DataSnapshot) in
                   // 1. 스냅샷 전체 로깅
                   print("전체 스냅샷: \(snapshot.value ?? "없음")")

                   guard let value = snapshot.value as? [String: [String: Any]] else {
                       print("데이터 형식 오류: \(type(of: snapshot.value))")
                       promise(.failure(NSError(domain: "Invalid data format", code: -1, userInfo: nil)))
                       return
                   }

                   let dateFormatter = ISO8601DateFormatter()

                   let missingModels = value.compactMap { (key, dict) -> MissingModel? in
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
                   print("변환된 모델 개수: \(missingModels.count)")
                   promise(.success(missingModels))
               }
           }
           .eraseToAnyPublisher()
    }
}
