//
//  CustomMapView.swift
//  PorPorCure
//
//  Created by Jupond on 12/26/24.
//

import UIKit
import MapKit

/*
 // 생성
 let mapView = CustomMapView(onMarkerTap: { marker in
     print("Selected marker: \(marker.title)")
 })

 // 뷰에 추가
 view.addSubview(mapView)
 NSLayoutConstraint.activate([
     mapView.topAnchor.constraint(equalTo: view.topAnchor),
     mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
     mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
     mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
 ])
 
 */


class CustomMapView: UIView, MKMapViewDelegate {
    private var mapView: MKMapView!
    private var locationManager: CLLocationManager?
    private var mapDelegate: MapDelegate?
    private var markerList: [MarkerModel] = []
    private var region: MKCoordinateRegion
    private var onMarkerTap: ((MarkerModel) -> Void)?
    
    private let defaultPosition = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 39.4699, longitude: -0.3763),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    // onMarkerTap을 설정하는 메서드 추가
    func setOnMarkerTap(_ action: @escaping (MarkerModel) -> Void) {
        self.onMarkerTap = action
    }
    
    // init(frame:) 추가
    override init(frame: CGRect) {
        self.region = defaultPosition
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        self.region = defaultPosition
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupMapView()
        setupLocationManager()
    }
    
    private func setupMapView() {
        mapView = MKMapView()
        mapView.delegate = self
        mapView.setRegion(region, animated: false)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setupLocationManager() {
        locationManager = CLLocationManager()
        mapDelegate = MapDelegate { [weak self] coordinate in
            guard let self = self else { return }
            self.region = MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
            self.mapView.setRegion(self.region, animated: true)
        }
        locationManager?.delegate = mapDelegate
    }
    
    func updateMarkers(_ markers: [MarkerModel]) {
        mapView.removeAnnotations(mapView.annotations)
        self.markerList = markers
        
        markers.forEach { model in
            let annotation = MarkerAnnotation(model: model)
            mapView.addAnnotation(annotation)
        }
    }
    
    func setRegion(_ region: MKCoordinateRegion, animated: Bool = true) {
        self.region = region
        mapView.setRegion(region, animated: animated)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MKPolyline else {
            return MKOverlayRenderer(overlay: overlay)
        }
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = .red
        renderer.lineWidth = 3
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let customAnnotation = annotation as? MarkerAnnotation else { return nil }
        
        let markerView = CustomMarkerView(
            annotation: customAnnotation,
            reuseIdentifier: "CustomAnnotation",
            model: customAnnotation.model,
            tapAction: { [weak self] model in
                self?.onMarkerTap?(model)
            }
        )
        return markerView
    }
//    
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        if let customView = view as? CustomMarkerView {
//            onMarkerTap?(customView.model)
//        }
//    }
}
