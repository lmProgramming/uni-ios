import Foundation
import SwiftUI
import CoreLocation
import CryptoKit

struct User: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var surname: String
    var email: String
    var passwordHash: String
}

func hash(data: Data) -> String {
    let digest = SHA256.hash(data: data)
    let hashString = digest
        .compactMap { String(format: "%02x", $0) }
        .joined()
    return hashString
}

var user: User = User(id: 0, name: "Mikolaj", surname: "Kubs", email: "mikikubs@gmail.com", passwordHash: hash(data: "1234".data(using: .utf8)!))

var users: [User] = [
    User(id: 0, name: "Mikolaj", surname: "Kubs", email: "mikikubs@gmail.com", passwordHash: hash(data: "1234".data(using: .utf8)!)),
    User(id: 1, name: "Martyna", surname: "Lopata", email: "mar1234@gmail.com", passwordHash: hash(data: "1234".data(using: .utf8)!)),
    User(id: 2, name: "Piotr", surname: "Lopata", email: "lop1234@gmail.com", passwordHash: hash(data: "1234".data(using: .utf8)!)),
    User(id: 3, name: "Fabia", surname: "Lopata", email: "12347@gmail.com", passwordHash: hash(data: "1234".data(using: .utf8)!)),
    User(id: 4, name: "Patryk", surname: "Piotr", email: "12345@gmail.com", passwordHash: hash(data: "1234".data(using: .utf8)!)),
    User(id: -1, name: "guest", surname: "guest", email: "1", passwordHash: hash(data: "1".data(using: .utf8)!))
]

func findUserEvents(userId: Int) -> [Event] {
    return events.filter { $0.ownerId == userId }
}

func GetNextUserID() -> Int {
    return (users.max(by: { $0.id < $1.id })?.id ?? 0) + 1
}
