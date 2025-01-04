//
//  MissingProtocol.swift
//  PorPorCure
//
//  Created by Jupond on 12/24/24.
//

import Foundation

protocol MissingProtocol {
    
    func loadList(completion: @escaping (Result<[MissingModel], Error>) -> Void)

}
