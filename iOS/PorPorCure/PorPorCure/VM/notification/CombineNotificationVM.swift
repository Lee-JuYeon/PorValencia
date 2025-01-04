//
//  NotificationViewModel.swift
//  PorPorCure
//
//  Created by Jupond on 12/25/24.
//

import Foundation
import Combine

@available(iOS 13.0, *)
class CombineNotificationVM : NotificationViewModelType {
    
    private let repository: NotificationRepository
    var cancellables: Set<AnyCancellable> = []
    @Published var list: [NotificationModel] = []
    @Published var errorMessage: String?
    
    init(repository: NotificationRepository) {
        self.repository = repository
    }
    
    func loadList() {
        // Combine Future를 사용한 방식
        Future<[NotificationModel], Error> { promise in
            self.repository.loadList { result in
                promise(result)
            }
        }
        .receive(on: DispatchQueue.main) // 메인 스레드에서 결과 처리
        .sink { [weak self] completion in
            switch completion {
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            case .finished:
                break
            }
        } receiveValue: { [weak self] list in
            self?.list = list
        }
        .store(in: &cancellables) // 구독 저장
    }
}
