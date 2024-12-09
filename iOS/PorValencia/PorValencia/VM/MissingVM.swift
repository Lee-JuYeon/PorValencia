//
//  MissingVM.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/13/24.
//

import Combine
import Foundation

// ViewModel
class MissingVM: ObservableObject {
    
    // Published properties for UI updates
    var missingSearchHint = "실종자 이름을 검색하세요"
    @Published var missingSearchText = ""
    @Published var currentMissingModel: MissingModel? = nil
    @Published var missingListResult: [MissingModel] = []
    @Published var editableMissingList : [MissingModel] = []
    
    @Published var notificationList : [NotificationMoel] = []
    
    private var notificationCancellables = Set<AnyCancellable>()
    private var cancellables = Set<AnyCancellable>()
    private let repository: MissingProtocol
    
    // Initialize with repository dependency
    init(repository: MissingProtocol) {
        self.repository = repository
        loadMissingModels() // Load all models initially
        loadNotificationModels()
    }
    
    private func loadNotificationModels(){
        repository.loadNotificationModels()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        print("Error loading notification models: \(error)")
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] models in
                    print("받은 데이터 : \(self?.notificationList)")
                    self?.notificationList = models.sorted { $0.date > $1.date } // 최신순으로 정렬
                }
            )
            .store(in: &notificationCancellables)
    }
    
    // Function to load all missing models
    private func loadMissingModels() {
        repository.loadMissingModels()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        print("Error loading missing models: \(error)")
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] models in
                    print("받은 데이터 : \(self?.missingListResult)")
                    self?.missingListResult = models
                    self?.editableMissingList = models
                }
            )
            .store(in: &cancellables)
    }
    
    func searchMissingPeople(name: String) {
        editableMissingList = name.isEmpty ? missingListResult : missingListResult.filter { $0.name.lowercased().contains(name.lowercased())
        }
    }
    
    func updateCurrentModel(model : MissingModel){
        currentMissingModel = model
    }
}


