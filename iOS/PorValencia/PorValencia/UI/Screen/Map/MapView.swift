//
//  MapView.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/9/24.
//

import SwiftUI
import MapKit
import CoreLocation


struct MapView: View {
    
    @EnvironmentObject var mapVM : MapVM
    @State private var isShowBottomSheet = false

    private let chipList = [
        MapChipsModel(uid: "uid0", image: "image_missing", englishTitle: "Missing", localTitle: String(localized: "실종자")),

//        MapChipsModel(uid: "uid1", image: "image_hospital", englishTitle: "Hospital", localTitle: "병원"),
//        MapChipsModel(uid: "uid2", image: "image_bed", englishTitle: "Shelter", localTitle: "대피소"),
//        MapChipsModel(uid: "uid3", image: "image_food", englishTitle: "Food", localTitle: "배식소"),
//        MapChipsModel(uid: "uid4", image: "image_emergency", englishTitle: "Help", localTitle: "갇혔어요!")
    ]
        
    // 초기 카메라 위치를 Valencia 좌표로 설정
    @State private var cameraPosition = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 39.4699, longitude: -0.3763), // 발렌시아의 초기 좌표
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)  // 초기 맵 스케일
    )
    private let locationManager = CLLocationManager()
        
    init(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    @State private var sheetContactView = false
    @State private var markerList : [MarkerModel] = []

    var body: some View {
        VStack(alignment: .trailing){
//            HStack(alignment: .center){
//                NeumorphismView(
//                    setMainColour: Color.mainColour,
//                    setLeftShadowColour: Color("leftShadowColour"),
//                    setRightShadowColour: Color("rightShadowColour"),
//                    setOnClick: {
//                        sheetContactView.toggle()
//                    }
//                ) {
//                    Image("image_bell")
//                        .resizable()
//                        .frame(
//                            width: 30,
//                            height: 30
//                        )
//                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
//
//                }
//                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
//            }
//            .frame(
//                minWidth: 0,
//                maxWidth: .infinity,
//                alignment: .trailing
//            )
            
            MapChipsView(setMapChips: chipList) { mapChipModel in
                print("클릭된거 : \(mapChipModel.localTitle)")
                let title = mapChipModel.englishTitle
                
                switch(title){
                case "Missing" :
                    markerList = MapManager.shared.changeMissingMarker(list: mapVM.missingList)
                case "Hospital" :
                    markerList = MapManager.shared.changeHospitalMarker(list: mapVM.hospitalList)
                case "Shelter" :
                    markerList = MapManager.shared.changeShelterMarker(list: mapVM.shelterList)
                case "Food" :
                    markerList = MapManager.shared.changeFoodMarker(list: mapVM.foodList)
                case "Help" :
                    markerList = MapManager.shared.changeHelpMeMarker(list: mapVM.helpMeList)
                default:
                    markerList = MapManager.shared.changeHospitalMarker(list: mapVM.hospitalList)
                }
                
            }
            
            CustomMapViewRepresentable(
                routeList: [],
                markerList: markerList,
                region: $cameraPosition,
                mapVM: mapVM,
                onClick: { markerModel in
                    mapVM.missingList.forEach { missingModel in
                        if(missingModel.name == markerModel.title){
                            mapVM.updateCurrentModel(model: missingModel)
                            isShowBottomSheet.toggle()
                        }
                    }
                }
            )
        }
        .onAppear(perform: {
            locationManager.delegate = MapDelegate(onLocationUpdate: { newLocation in
                self.cameraPosition.center = newLocation
            })
            locationManager.startUpdatingLocation()
            
            // 초기 데이터 로딩
            mapVM.loadHospitalList()
            mapVM.loadShelterList()
            mapVM.loadFoodListList()
            mapVM.loadHelpMeListList()
            mapVM.loadMissingModels()
        })
        .background(Color("mainColour"))
        .sheet(isPresented: $sheetContactView) {
           ContactView()
        }
        .sheet(
            isPresented: $isShowBottomSheet,
            onDismiss: {
                isShowBottomSheet = false
            },
            content: {
                var chartList : [ChartModel] {
                    var data: [ChartModel] = [
                        ChartModel(title: String(localized: "이름"), value: mapVM.currentMissingModel?.name ?? "")
                    ]
                    
                    // 성별
                    if let gender = mapVM.currentMissingModel?.gender.rawValue {
                        data.append(ChartModel(title: String(localized: "성별"), value: gender))
                    }
                    
                    // 실종상태
                    data.append(ChartModel(title: String(localized: "실종 현황"), value: MissingManager.shared.getMissingState(setType: mapVM.currentMissingModel?.missingState)))

                    // 실종날짜
                    data.append(ChartModel(title: String(localized: "실종 날짜"), value: MissingManager.shared.getDateByString(setDate: mapVM.currentMissingModel?.date)))
                    
                    // 실종 위치
                    if let missingPlace = mapVM.currentMissingModel?.zone {
                        data.append(ChartModel(title: String(localized: "실종 위치"), value: missingPlace))
                    }
                    
                    // 외관 특징
                    if let character = mapVM.currentMissingModel?.character {
                        data.append(ChartModel(title:String(localized: "외관상 특징"), value: character))
                    }
                    
                    return data
                }
                
                
                BottomSheetView(content: {
                    VStack(alignment: .leading){
                        AsyncImage(url: URL(string: mapVM.currentMissingModel?.imageURL ?? "")) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            case .failure:
                                Image(systemName: "xmark.circle")
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: 400)
                        
                        ChartView(chartData: chartList)
                        Text("Las coordenadas de latitud y longitud son una ubicación estimada.")
                            .font(.system(size: 20,weight: Font.Weight.light))
                        
                        
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                })
            }
        )
    }
}
