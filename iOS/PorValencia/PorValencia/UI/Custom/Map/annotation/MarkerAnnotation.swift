//
//  MarkerAnnotation.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/9/24.
//

import MapKit

// Custom Annotation Class to hold the CollectingPlaceModel
class MarkerAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var model: MarkerModel

    init(model: MarkerModel) {
        self.model = model
        self.coordinate = CLLocationCoordinate2D(latitude: model.lat, longitude: model.lon)
    }
}
