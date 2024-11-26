//
//  MissingProtocol.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/13/24.
//

import Combine
import Foundation

class MissingRepository : MissingProtocol {
    func loadMissingModels() -> AnyPublisher<[MissingModel], any Error> {
        DummyPack.shared.dummyList
           
    }
}
