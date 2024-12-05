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
    var endDate: Date?
    var description: String
    var ownerId: Int
    
    var imageName: String
    var category: String 
    var image: Image {
        Image(imageName)
    }
    
    var location: Location
    
    struct Coordinates: Hashable, Codable{
        var latitude: Double
        var longitude: Double
    }
}

let categories = ["All", "Music", "Sports", "Art", "Food", "Learning"]

func GetNextEventID() -> Int {
    return (events.max(by: { $0.id < $1.id })?.id ?? 0) + 1
}
