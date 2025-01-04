//
//  MissingVMFactory.swift
//  PorPorCure
//
//  Created by Jupond on 12/26/24.
//

import Foundation

// Factory를 통한 ViewModel 생성
class MissingVMFactory {
    static func createViewModel(repository: MissingRepository) -> MissingViewModelType {
        if #available(iOS 13.0, *) {
            return CombineMissingVM(repository: repository)
        } else {
            return RxMissingVM(repository: repository)
        }
    }
}
