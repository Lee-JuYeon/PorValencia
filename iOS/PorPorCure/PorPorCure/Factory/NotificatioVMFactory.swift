//
//  NotificationModel.swift
//  PorPorCure
//
//  Created by Jupond on 12/31/24.
//

import Foundation

class NotificationVMFactory {
    static func createViewModel(repository: NotificationRepository) -> NotificationViewModelType {
        if #available(iOS 13.0, *) {
            return CombineNotificationVM(repository: repository)
        } else {
            return RxNotificationVM(repository: repository)
        }
    }
}
