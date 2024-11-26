import SwiftUI
import MapKit

struct MapView: View {
    var coordinate: CLLocationCoordinate2D
    var label: String
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: .topTrailing) {
                    Map(coordinateRegion: .constant(region), showsUserLocation: true, annotationItems: events) { event in
                        // MapAnnotation displays each event on the map
                        MapPin(coordinate: event.location.locationCoordinate, tint: .blue) // You can also use MapMarker or MapAnnotation if you want custom views for each pin
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    // Adding a label at the top right
                    Text(label)
                        .font(.headline)
                        .padding(8)
                        .background(Color.blue.opacity(0.7))
                        .cornerRadius(8)
                        .padding(16)
                        .shadow(radius: 5)
                        .foregroundStyle(Color.white)
                }
                
                Spacer()
                
                BottomTabBar(selected: 2)
            }
            .navigationTitle("Map")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    private var region: MKCoordinateRegion {
        // Calculate a region that fits all event locations (simple approximation)
        if let firstEvent = events.first {
            let center = firstEvent.location.locationCoordinate
            return MKCoordinateRegion(
                center: center,
                span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            )
        } else {
            // If no events, return a default region
            return MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // Default to San Francisco
                span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            )
        }
    }
}

#Preview {
    MapView(coordinate: events[0].location.locationCoordinate, label: "Some label")
}
