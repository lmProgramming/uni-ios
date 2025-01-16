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
    
    var signature: String {
        name + " " + surname
    }
}

func hash(data: Data) -> String {
    let digest = SHA256.hash(data: data)
    let hashString = digest
        .compactMap { String(format: "%02x", $0) }
        .joined()
    return hashString
}

var user: User = User(id: 0, name: "Mikolaj", surname: "Kubs", email: "mikikubs@gmail.com", passwordHash: hash(data: "1234".data(using: .utf8)!))

var users = [
    User(id: 0, name: "Mikolaj", surname: "Kubs", email: "mikikubs@gmail.com", passwordHash: hash(data: "1234".data(using: .utf8)!)),
    User(id: 1, name: "Martyna", surname: "Lopata", email: "mar1234@gmail.com", passwordHash: hash(data: "1234".data(using: .utf8)!)),
    User(id: 2, name: "Piotr", surname: "Lopata", email: "lop1234@gmail.com", passwordHash: hash(data: "1234".data(using: .utf8)!)),
    User(id: 3, name: "Fabia", surname: "Lopata", email: "12347@gmail.com", passwordHash: hash(data: "1234".data(using: .utf8)!)),
    User(id: 4, name: "Patryk", surname: "Piotr", email: "12345@gmail.com", passwordHash: hash(data: "1234".data(using: .utf8)!)),
    User(id: 5, name: "Anna", surname: "Nowak", email: "anna.nowak12@mail.com", passwordHash: hash(data: "qwerty123".data(using: .utf8)!)),
    User(id: 6, name: "Jakub", surname: "Kowalski", email: "jakub.k@kmail.com", passwordHash: hash(data: "abcde12345".data(using: .utf8)!)),
    User(id: 7, name: "Karolina", surname: "Wójcik", email: "karolina.wojcik77@gmail.com", passwordHash: hash(data: "1Qaz2Wsx".data(using: .utf8)!)),
    User(id: 8, name: "Szymon", surname: "Zalewski", email: "szymon.zalewski@example.org", passwordHash: hash(data: "password!2023".data(using: .utf8)!)),
    User(id: 9, name: "Katarzyna", surname: "Sikora", email: "katarzyna.sikora@mailbox.com", passwordHash: hash(data: "Sunshine123".data(using: .utf8)!)),
    User(id: 10, name: "Tomasz", surname: "Jankowski", email: "t.jankowski@outlook.com", passwordHash: hash(data: "T0mmy_2023".data(using: .utf8)!)),
    User(id: 11, name: "Magdalena", surname: "Kaczmarek", email: "magda.kaczmarek123@gmail.com", passwordHash: hash(data: "secureP@ss1".data(using: .utf8)!)),
    User(id: 12, name: "Adam", surname: "Kwiatkowski", email: "adam.kwiatkowski@yahoo.com", passwordHash: hash(data: "ilov3Coding".data(using: .utf8)!)),
    User(id: 13, name: "Agnieszka", surname: "Mazur", email: "agnieszka.mazur@company.net", passwordHash: hash(data: "3nterTheF0rce".data(using: .utf8)!)),
    User(id: 14, name: "Piotr", surname: "Pawlak", email: "piotr.pawlak@domain.com", passwordHash: hash(data: "P@ssw0rd!23".data(using: .utf8)!))
]

func findUserEvents(userId: Int) -> [Event] {
    return events.filter { $0.ownerId == userId }
}

func GetNextUserID() -> Int {
    return (users.max(by: { $0.id < $1.id })?.id ?? 0) + 1
}
