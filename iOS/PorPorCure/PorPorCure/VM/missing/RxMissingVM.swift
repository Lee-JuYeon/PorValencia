//
//  RxMissingVM.swift
//  PorPorCure
//
//  Created by Jupond on 12/26/24.
//

import Foundation
import RxSwift

class RxMissingVM : MissingViewModelType {
    private let repository: MissingRepository
    let disposeBag = DisposeBag()
    private let missingListSubject = PublishSubject<[MissingModel]>()
    private let errorSubject = PublishSubject<String>()
    
    var missingListObservable: Observable<[MissingModel]> {
        return missingListSubject.asObservable()
    }
    
    var errorObservable: Observable<String> {
        return errorSubject.asObservable()
    }
    
    init(repository: MissingRepository) {
        self.repository = repository
    }
    
    func loadMissingList() {
        repository.loadList { [weak self] result in
            switch result {
            case .success(let list):
                self?.missingListSubject.onNext(list)
            case .failure(let error):
                self?.errorSubject.onNext(error.localizedDescription)
            }
        }
    }
}
