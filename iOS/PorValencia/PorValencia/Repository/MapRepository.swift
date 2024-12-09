//
//  MapRepository.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/14/24.
//

import Combine
import Foundation

class MapRepository : MapProtocol {
    func loadShelterList() -> AnyPublisher<[ShelterModel], any Error> {
        // DummyPack 데이터를 Just로 래핑하고 AnyPublisher로 변환
        Just(DummyPack.shared.shelterList)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func loadFoodList() -> AnyPublisher<[FoodModel], any Error> {
        // DummyPack 데이터를 Just로 래핑하고 AnyPublisher로 변환
        Just(DummyPack.shared.foodList)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func loadHelpMeList() -> AnyPublisher<[HelpMeModel], any Error> {
        // DummyPack 데이터를 Just로 래핑하고 AnyPublisher로 변환
        Just(DummyPack.shared.helpmeList)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    
    func loadHospitalList() -> AnyPublisher<[HospitalModel], Error> {
        // DummyPack 데이터를 Just로 래핑하고 AnyPublisher로 변환
        Just(DummyPack.shared.hospitalList)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
}
