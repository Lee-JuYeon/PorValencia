//
//  MissingProtocol.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/13/24.
//

import Combine
import Foundation

protocol MissingProtocol {
    func loadNotificationModels() -> AnyPublisher<[NotificationMoel], Error>
    func loadMissingModels() -> AnyPublisher<[MissingModel], Error>
}
