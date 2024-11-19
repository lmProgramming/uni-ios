//
//  Landmark.swift
//  Landmarks
//
//  Created by stud on 15/10/2024.
//

import Foundation
import SwiftUI
import CoreLocation

struct Event: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var startDate: Date
    var endDate: Date
    var description: String
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
    
    var location: Location
    
    struct Coordinates: Hashable, Codable{
        var latitude: Double
        var longitude: Double
    }
}
