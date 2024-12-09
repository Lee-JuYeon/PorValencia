//
//  MapVM.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/14/24.
//

import SwiftUI
import Combine

class MapVM: ObservableObject {
    
    @Published var currentHospitalModel : HospitalModel? = nil
    @Published var currentMissingModel: MissingModel? = nil

    @Published var hospitalList : [HospitalModel] = []
    @Published var shelterList: [ShelterModel] = []
    @Published var foodList : [FoodModel] = []
    @Published var helpMeList : [HelpMeModel] = []
    @Published var missingList : [MissingModel] = []
    
    private var hospitalCancellables = Set<AnyCancellable>()
    private var shelterCancellables = Set<AnyCancellable>()
    private var foodCancellables = Set<AnyCancellable>()
    private var helpMeCancellables = Set<AnyCancellable>()
    private var missingCancellables = Set<AnyCancellable>()

    private let mapRepository: MapProtocol
    private let missingRepository : MissingProtocol
    
    init(
        mapRepository: MapRepository,
        missingRepository: MissingRepository
    ) {
        self.mapRepository = mapRepository
        self.missingRepository = missingRepository
    }
    
    func loadHospitalList() {
        mapRepository.loadHospitalList()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        print("Error loading hospital models: \(error)")
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] list in
                    self?.hospitalList = list
                }
            )
            .store(in: &hospitalCancellables)
    }
    
    func loadShelterList() {
        mapRepository.loadShelterList()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        print("Error loading shelter models: \(error)")
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] list in
                    self?.shelterList = list
                }
            )
            .store(in: &shelterCancellables)
    }
    
    func loadFoodListList() {
        mapRepository.loadFoodList ()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        print("Error loading food models: \(error)")
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] list in
                    self?.foodList = list
                }
            )
            .store(in: &foodCancellables)
    }
    
    func loadHelpMeListList() {
        mapRepository.loadHelpMeList()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        print("Error loading helpMe models: \(error)")
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] list in
                    self?.helpMeList = list
                }
            )
            .store(in: &helpMeCancellables)
    }
    
    func loadMissingModels() {
        missingRepository.loadMissingModels()
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
                    self?.missingList = models
                    self?.missingList = models
                }
            )
            .store(in: &missingCancellables)
    }
    
    func updateCurrentModel(model : MissingModel){
        currentMissingModel = model
    }
}
