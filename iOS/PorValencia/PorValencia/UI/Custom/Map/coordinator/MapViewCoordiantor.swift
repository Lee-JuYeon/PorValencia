//
//  MapViewCoordiantorDelegate.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/9/24.
//

import Foundation
import MapKit


// MKMapViewDelegate를 구현하는 코디네이터 클래스
class MapViewCoordinator: NSObject, MKMapViewDelegate {
    var parent: CustomMapViewRepresentable
    var tapAction: ((MarkerModel) -> Void) // Closure for handling tap events

    init(
        parent: CustomMapViewRepresentable,
        tapAction: @escaping ((MarkerModel) -> Void)
    ) {
        self.tapAction = tapAction
        self.parent = parent
    }

    // 경로 렌더링 설정
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MKPolyline else {
            return MKOverlayRenderer(overlay: overlay)
        }
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = .red
        renderer.lineWidth = 3
        return renderer
    }
    
    // 마커 뷰 생성
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let customAnnotation = annotation as? MarkerAnnotation else { return nil }

        // Create the custom marker view and pass the tapAction closure
        let markerView = CustomMarkerView(
            annotation: customAnnotation,
            reuseIdentifier: "CustomAnnotation",
            model: customAnnotation.model,
            tapAction: { [self] model in
                tapAction(model) // Execute the closure when tapped
            }
        )
        return markerView
    }

    /*
     마커 클릭리스너 이벤트 처리
     didSelect메서드로 클릭이벤트를 구현하여 상위뷰인 MkMapView와의 클릭이벤트 충돌을 방지했다.
     */
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let customView = view as? CustomMarkerView {
            parent.mapVM.currentHospitalModel?.uid = customView.model.uid
            print("선택된 장소: \(customView.model.title)")
        }
    }
}

