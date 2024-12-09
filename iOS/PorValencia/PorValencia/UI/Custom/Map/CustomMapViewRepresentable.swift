//
//  CustomMapViewRepresentable.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/9/24.
//

import SwiftUI
import UIKit
import MapKit


// MapViewRepresentable: SwiftUI에서 UIKit의 MKMapView를 사용하기 위한 UIViewRepresentable
struct CustomMapViewRepresentable: UIViewRepresentable {
    /*
     MKAnnotation 내부에 추가된 UIView는 UIView.isUserInteractionEnabled = true를 설정하더라도 기본적으로 사용자 상호작용 처리를 하지 않도록 설정된다.
     그 이유는 MKMapView 자체의 다른 상호작용 (맵 터치이동, 축소)등과 충돌할 수 있기 때문.
     따라서, MKAnnotationView에 추가된 뷰나 제스쳐 인식이 잘 작동하도록 확이낳고 상위 뷰인 MKMapView가 이 상호작용을 방해하지 않도록 해야한다.
     
     클릭이벤트의 해법 : 제스처 인식기(UITapGestureRecognizer) 대신 MKMapViewDelegate의 didSelect 메서드를 사용하여 마커가 선택되었을 때의 처리를 더 명확하게 합니다.
     */
    var routeList: [RouteModel]
    var markerList: [MarkerModel]
    @Binding var region: MKCoordinateRegion
    var mapVM : MapVM
    var onClick: ((MarkerModel) -> Void)
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.setRegion(region, animated: true)
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeOverlays(uiView.overlays)
        uiView.removeAnnotations(uiView.annotations)
        
        addMarker(to: uiView, context: context)
        addRoute(to: uiView)
        uiView.setRegion(region, animated: true)
    }
    
    // 마크 추가
    private func addMarker(to mapView: MKMapView, context: Context) {
        markerList.forEach { model in
            let annotation = MarkerAnnotation(model: model)
            annotation.coordinate = CLLocationCoordinate2D(latitude: model.lat, longitude: model.lon)
            mapView.addAnnotation(annotation)
        }
    }
    
    // 루트 추가
    private func addRoute(to mapView: MKMapView) {
        routeList.forEach { route in
            let coordinates = route.paths.map { CLLocationCoordinate2D(latitude: $0.lat, longitude: $0.lon) }
            let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
            mapView.addOverlay(polyline)
        }
    }
    
    // MKMapViewDelegate를 사용하기 위한 코디네이터 생성
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(
            parent: self,
            tapAction: { selectedMarker in
                onClick(selectedMarker) // Pass the selected MarkerModel
            }
        )
    }
}
