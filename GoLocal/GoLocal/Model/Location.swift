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

public struct Location: Hashable, Codable {
    var city: String
    var country: String
    var streetName: String
    var houseId: String
    
    var coordinates: Coordinates
    var locationCoordinate: CLLocationCoordinate2D{
        CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
    
    public struct Coordinates: Hashable, Codable{
        var latitude: Double
        var longitude: Double
    }
    
    var description: String {
        return "\(city), \(country): \(houseId) - \(streetName)"
    }
    
    var valid: Bool {
        return city != ""
    }
}

func newMockLocation() -> Location {
    return Location(city: "Wroclaw", country: "PL", streetName: "Ladna", houseId: "12", coordinates: Location.Coordinates(latitude: 1, longitude: 2))
}

let mockLocation = Location(city: "Wroclaw", country: "PL", streetName: "Ladna", houseId: "12", coordinates: Location.Coordinates(latitude: 1, longitude: 2))
