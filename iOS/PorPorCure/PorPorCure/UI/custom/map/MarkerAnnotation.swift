//
//  MarkerAnnotation.swift
//  PorPorCure
//
//  Created by Jupond on 12/24/24.
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
