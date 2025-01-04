//
//  MapViewCoordinator.swift
//  PorPorCure
//
//  Created by Jupond on 12/24/24.
//

import Foundation
import RxSwift

class RxNotificationVM : NotificationViewModelType {
    
    private let repository: NotificationRepository
    let disposeBag = DisposeBag()
    private let listSubject = PublishSubject<[NotificationModel]>()
    private let errorSubject = PublishSubject<String>()
    
    var listObservable: Observable<[NotificationModel]> {
        return listSubject.asObservable()
    }
    
    var errorObservable: Observable<String> {
        return errorSubject.asObservable()
    }
    
    init(repository: NotificationRepository) {
        self.repository = repository
    }
    
    func loadList() {
        repository.loadList { [weak self] result in
            switch result {
            case .success(let list):
                self?.listSubject.onNext(list)
            case .failure(let error):
                self?.errorSubject.onNext(error.localizedDescription)
            }
        }
    }
}
