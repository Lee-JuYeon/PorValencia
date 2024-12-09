//
//  MapDelegate.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/14/24.
//

import SwiftUI
import MapKit
import CoreLocation

class MapDelegate: NSObject, CLLocationManagerDelegate {
    private let onLocationUpdate: (CLLocationCoordinate2D) -> Void
    
    init(onLocationUpdate: @escaping (CLLocationCoordinate2D) -> Void) {
        self.onLocationUpdate = onLocationUpdate
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        onLocationUpdate(location.coordinate)
        manager.stopUpdatingLocation() // 위치를 처음 한 번만 가져오기 위해 중지
    }
}
