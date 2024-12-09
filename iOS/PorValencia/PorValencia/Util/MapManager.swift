//
//  MapManager.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/11/24.
//

import CoreLocation

final class MapManager {
    // 싱글톤 인스턴스
    static let shared = MapManager()
    
    // 주소로부터 위도/경도 찾기 (정방향 지오코딩)
    func geocodeAddress(address: String) {
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let error = error {
                print("Geocoding failed: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first, let location = placemark.location {
                let latitude = location.coordinate.latitude
                let longitude = location.coordinate.longitude
                print("Latitude: \(latitude), Longitude: \(longitude)")
            } else {
                print("No results found for this address.")
            }
        }
    }
    
    // 위도/경도로부터 주소 찾기 (역방향 지오코딩)
    func reverseGeocodeCoordinates(latitude: Double, longitude: Double) {
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Reverse geocoding failed: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first {
                let address = placemark.name ?? "No name"
                let city = placemark.locality ?? "No city"
                let country = placemark.country ?? "No country"
                
                print("Address: \(address), City: \(city), Country: \(country)")
            } else {
                print("No address found for these coordinates.")
            }
        }
    }
    
    func changeHospitalMarker(list: [HospitalModel]) -> [MarkerModel] {
        list.enumerated().map { index, hospitalModel in
            MarkerModel(
                uid: "hospital_\(index)", // index를 문자열로 변환하여 uid에 사용
                title: hospitalModel.hospitalTitle,
                subTitle: "",
                image: "image_hospital",
                lon: hospitalModel.hospitalLon,
                lat: hospitalModel.hospitalLat,
                address: hospitalModel.hospitalAddress
            )
        }
    }
    
    func changeShelterMarker(list : [ShelterModel]) -> [MarkerModel] {
        list.enumerated().map { index, shelterModel in
            MarkerModel(
                uid: "shelter_\(index)", // index를 문자열로 변환하여 uid에 사용
                title: shelterModel.title,
                subTitle: "",
                image: "image_bed",
                lon: shelterModel.lon,
                lat: shelterModel.lat,
                address: shelterModel.address
            )
        }
    }
    
    func changeFoodMarker(list : [FoodModel]) -> [MarkerModel] {
        list.enumerated().map { index, foodModel in
            MarkerModel(
                uid: "food_\(index)", // index를 문자열로 변환하여 uid에 사용
                title: foodModel.title,
                subTitle: "",
                image: "image_food",
                lon: foodModel.lon,
                lat: foodModel.lat,
                address: foodModel.address
            )
        }
    }
    
    func changeHelpMeMarker(list : [HelpMeModel]) -> [MarkerModel] {
        list.enumerated().map { index, helpMeModel in
            MarkerModel(
                uid: "helpme_\(index)", // index를 문자열로 변환하여 uid에 사용
                title: helpMeModel.text,
                subTitle: "",
                image: "image_emergency",
                lon: helpMeModel.lon,
                lat: helpMeModel.lat,
                address: helpMeModel.address
            )
        }
    }
    
    func changeMissingMarker(list : [MissingModel]) -> [MarkerModel] {
        list.enumerated().map { index, model in
            MarkerModel(
                uid: "missing_\(index)", // index를 문자열로 변환하여 uid에 사용
                title: model.name,
                subTitle: "",
                image: model.imageURL,
                lon: model.lon,
                lat: model.lat,
                address: model.zone
            )
        }
    }
    
    
    
    // private init을 통해 인스턴스화 방지
    private init() {}
}
