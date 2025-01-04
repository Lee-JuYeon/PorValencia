//
//  MapDelegate.swift
//  PorPorCure
//
//  Created by Jupond on 12/24/24.
//

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
        manager.stopUpdatingLocation()
    }
}
