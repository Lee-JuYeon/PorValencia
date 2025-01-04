//
//  MapViewController.swift
//  PorPorCure
//
//  Created by Jupond on 12/23/24.
//

import Foundation
import UIKit

class MapViewController : UIViewController {
    
    private let mapView : CustomMapView = {
       let view = CustomMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let chipsView : ChipsView = {
        let view = ChipsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setChipsView(){
        let chips = [
            ChipModel(id: "1", title: "실종자"),
            ChipModel(id: "2", title: "Kotlin"),
            ChipModel(id: "3", title: "JavaScript"),
            ChipModel(id: "4", title: "Python"),
            ChipModel(id: "5", title: "Java"),
        ]
        chipsView.setChips(chips)
        chipsView.onChipSelected = { [self] selectedChipModel in
            if (selectedChipModel.isSelected == true){
                switch selectedChipModel.title {
                case "실종자":
                    setMissingVM()
                default :
                    setMissingVM()
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setChipsView()
        setView()
        setMissingVM()
    }

    private func setView(){
        view.backgroundColor = UIColor(named: "mainColour")
        
        view.addSubview(mapView)
        view.addSubview(chipsView)
        
        NSLayoutConstraint.activate([
            chipsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            chipsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            chipsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            chipsView.heightAnchor.constraint(equalToConstant: 50),
            
            mapView.topAnchor.constraint(equalTo: chipsView.bottomAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func setMissingVM() {
        print("setMissingVM 실행")

        // ViewController에서
        let missingRepository = MissingRepository()
        let missingVM = MissingVMFactory.createViewModel(repository: missingRepository)

        if #available(iOS 13.0, *) {
            // iOS 13 이상에서 Combine 사용시
            if let combineMissingVM = missingVM as? CombineMissingVM {
                combineMissingVM.$missingList
                    .sink { list in
                        // UI 업데이트
                        let convertList = MapManager.shared.changeMissingMarker(list: list)
//                        self.mapView.updateMarkers(convertList)
                        self.mapView.updateMarkers(self.dummyMarkers)
                    }
                    .store(in: &combineMissingVM.cancellables)
            }
        } else {
            // iOS 13 미만에서 RxSwift 사용시
            if let rxMissingVM = missingVM as? RxMissingVM {
                rxMissingVM.missingListObservable
                    .subscribe(onNext: { list in
                        // UI 업데이트
                        // UI 업데이트
                        let convertList = MapManager.shared.changeMissingMarker(list: list)
//                        self.mapView.updateMarkers(convertList)
                        self.mapView.updateMarkers(self.dummyMarkers)
                    })
                    .disposed(by: rxMissingVM.disposeBag)
            }
        }

        mapView.setOnMarkerTap { markerModel in
            let markerModelUID = markerModel.uid
            
            
            let missingSheetView = MissingSheetView()
            missingSheetView.setMissingModel(model: MissingModel(
                uid: "uid1",
                name: "msissing pepole name 1",
                date: Date(),
                zone: "misisng place zone 1",
                imageURL: "https://pbs.twimg.com/media/GflFwKBWsAA-xJ_?format=jpg&name=small",
                gender: GenderType.MALE,
                character: "mssing people character type 1,2,3,4,5,6",
                lon: -0.357220,
                lat: 39.453581
            ))
            missingSheetView.presentInKeyWindow()
        }
    }
    
    
    
    let dummyMarkers: [MarkerModel] = [
        MarkerModel(
            uid: "1",
            title: "City of Arts and Sciences",
            subTitle: "Futuristic architecture complex",
            image: "https://pbs.twimg.com/media/GflFwKBWsAA-xJ_?format=jpg&name=small",
            lon: -0.357220,
            lat: 39.453581,
            address: "Av. del Professor López Piñero, 7, 46013 Valencia, Spain"
        ),
        MarkerModel(
            uid: "2",
            title: "Valencia Cathedral",
            subTitle: "Historic cathedral with famous 'Holy Grail'",
            image: "https://pbs.twimg.com/media/GgMUTpeWMAANSG4?format=jpg&name=small",
            lon: -0.375683,
            lat: 39.475330,
            address: "Plaça de l'Almoina, s/n, 46003 Valencia, Spain"
        ),
        MarkerModel(
            uid: "3",
            title: "Central Market of Valencia",
            subTitle: "Vibrant indoor market with fresh goods",
            image: "https://pbs.twimg.com/media/GgK8AyqWcAAkBcM?format=jpg&name=small",
            lon: -0.377391,
            lat: 39.470240,
            address: "Plaça de la Ciutat de Bruges, s/n, 46001 Valencia, Spain"
        ),
        MarkerModel(
            uid: "4",
            title: "Turia Gardens",
            subTitle: "Large urban park in old riverbed",
            image: "https://pbs.twimg.com/media/GgB6pd_WcAAdFUu?format=jpg&name=small",
            lon: -0.367000,
            lat: 39.465800,
            address: "Jardín del Turia, 46010 Valencia, Spain"
        )
    ]

}
