//
//  Landmark.swift
//  Landmarks
//
//  Created by stud on 15/10/2024.
//

import Foundation
import SwiftUI
import CoreLocation

var locationManager: CLLocationManager = CLLocationManager()

struct Location: Hashable, Codable {
    var city: String
    var country: String
    var streetName: String
    var houseId: String
    
    private var coordinates: Coordinates
    var locationCoordinate: CLLocationCoordinate2D{
        CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
    
    struct Coordinates: Hashable, Codable{
        var latitude: Double
        var longitude: Double
    }
    
    var description: String {
        return "\(city), \(country): \(houseId) - \(streetName)"
    }
}
