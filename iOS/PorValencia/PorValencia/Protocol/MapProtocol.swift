//
//  MapProtocol.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/14/24.
//

import Combine
import Foundation

protocol MapProtocol {
    func loadHospitalList() -> AnyPublisher<[HospitalModel], Error>
    func loadShelterList() -> AnyPublisher<[ShelterModel], Error>
    func loadFoodList() -> AnyPublisher<[FoodModel], Error>
    func loadHelpMeList() -> AnyPublisher<[HelpMeModel], Error>
}

