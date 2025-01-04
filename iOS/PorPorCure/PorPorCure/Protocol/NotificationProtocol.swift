//
//  NotificationProtocol.swift
//  PorPorCure
//
//  Created by Jupond on 12/24/24.
//

import Foundation

protocol NotificationProtocol {
    
    func loadList(completion: @escaping (Result<[NotificationModel], Error>) -> Void)
    
}
