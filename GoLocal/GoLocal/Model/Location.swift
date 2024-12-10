import Foundation
import SwiftUI
import CoreLocation
import Contacts

var locationManager: CLLocationManager = CLLocationManager()

extension CLPlacemark {
    /// street name, eg. Infinite Loop
    var streetName: String? { thoroughfare }
    /// // eg. 1
    var streetNumber: String? { subThoroughfare }
    /// city, eg. Cupertino
    var city: String? { locality }
    /// neighborhood, common name, eg. Mission District
    var neighborhood: String? { subLocality }
    /// state, eg. CA
    var state: String? { administrativeArea }
    /// county, eg. Santa Clara
    var county: String? { subAdministrativeArea }
    /// zip code, eg. 95014
    var zipCode: String? { postalCode }
    /// postal address formatted
    @available(iOS 11.0, *)
    var postalAddressFormatted: String? {
        guard let postalAddress = postalAddress else { return nil }
        return CNPostalAddressFormatter().string(from: postalAddress)
    }
}
    
public struct Coordinates: Hashable, Codable{
    var latitude: Double
    var longitude: Double
}

func getLocationFromCoordinates(_ coordinates: Coordinates, completion: @escaping (String) -> Void) {
    let location = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
    
    location.placemark { placemark, error in
        guard let placemark = placemark else {
            print("Error:", error ?? "nil")
            completion("Unable to retrieve address")
            return
        }
        
        let address = (placemark.postalAddressFormatted ?? "")
        
        completion(address)
    }
}

extension CLLocation {
    func placemark(completion: @escaping (_ placemark: CLPlacemark?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first, $1) }
    }
}

func newMockLocation() -> Coordinates {
    return Coordinates(latitude: 1, longitude: 2)
}

var mockLocation: Coordinates = Coordinates(latitude: 1, longitude: 1)
