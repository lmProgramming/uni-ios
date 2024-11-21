//
//  Event 2.swift
//  GoLocal
//
//  Created by stud on 21/11/2024.
//



import Foundation
import SwiftUI
import CoreLocation

struct User: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var surname: String
}

var user: User = User(id: 0, name: "Mikolaj", surname: "Kubs")
