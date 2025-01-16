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
    var coordinates: Coordinates
    var imageNames: [String]?
    
    var image: Image {
        Image(imageName)
    }
    
    var images: [Image] {
        imageNames?.map { Image($0) } ?? []
    }
    
    var cllCoordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }

    var locationText: String?
}

class EventViewModel: ObservableObject {
    @Published var event: Event
    
    init(event: Event) {
        self.event = event
        fetchLocationText()
    }
    
    func fetchLocationText() {
        getLocationFromCoordinates(event.coordinates) { [weak self] address in
            DispatchQueue.main.async {
                self?.event.locationText = address
            }
        }
    }
}


let categories = ["All", "Music", "Sports", "Art", "Food", "Learning"]

func GetNextEventID() -> Int {
    return (events.max(by: { $0.id < $1.id })?.id ?? 0) + 1
}
