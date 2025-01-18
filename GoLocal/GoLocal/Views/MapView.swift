import SwiftUI
import MapKit
import Contacts

import MapKit

extension CLLocationCoordinate2D: Equatable {
    public static func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

extension MKCoordinateSpan: Equatable {
    public static func ==(lhs: MKCoordinateSpan, rhs: MKCoordinateSpan) -> Bool {
        return lhs.latitudeDelta == rhs.latitudeDelta && lhs.longitudeDelta == rhs.longitudeDelta
    }
}

extension MKCoordinateRegion: Equatable {
    public static func ==(lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        return lhs.center == rhs.center && lhs.span == rhs.span
    }
}

struct MapView: View {
    @Binding var loggedIn: Bool
    var coordinate: CLLocationCoordinate2D
    var label: String
        
    @State private var selectedEvent: Event? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack(alignment: .topTrailing) {
                    Map(coordinateRegion: .constant(region), showsUserLocation: true, annotationItems: events) { event in
                        MapAnnotation(coordinate: event.cllCoordinates ) {
                            VStack {
                                Image(uiImage: UIImage(named: event.imageName) ?? UIImage())
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                    .shadow(radius: 5)
                                
                                Text(event.name)
                                    .font(.caption)
                                    .padding(5)
                                    .foregroundStyle(Color.black)
                                    .background(Color.white)
                                    .cornerRadius(5)
                                    .shadow(radius: 5)
                            }
                            .onTapGesture {
                                selectedEvent = event
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
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
                
                BottomTabBar(loggedIn: $loggedIn, selected: 2)
            }
            .navigationTitle("Map")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            NavigationLink(
                destination: EventDetail(event: selectedEvent ?? events.first!),
                isActive: .constant(selectedEvent != nil)
            ) {
                EmptyView()
            }
        }
    }
    
    private var region: MKCoordinateRegion {
        if let firstEvent = events.first {
            let center = firstEvent.cllCoordinates
            return MKCoordinateRegion(
                center: center,
                span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            )
        } else {
            return MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
                span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            )
        }
    }
}

struct MapInsideView: View {
    var coordinate: CLLocationCoordinate2D
    var label: String
    var events: [Event]
    var eventAlwaysShown: Event
    
    @State private var selectedEvent: Event? = nil
    @State private var region: MKCoordinateRegion
    
    @State private var shouldShowAnnotations: Bool = false
    
    init(coordinate: CLLocationCoordinate2D, label: String, events: [Event], eventAlwaysShown: Event) {
        self.coordinate = coordinate
        self.label = label
        self.events = events
        _region = State(initialValue: MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        ))
        self.eventAlwaysShown = eventAlwaysShown
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topTrailing) {
                Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: shouldShowAnnotations ? events : [eventAlwaysShown]) { event in
                    MapAnnotation(coordinate: event.cllCoordinates) {
                        VStack {
                            Image(uiImage: UIImage(named: event.imageName) ?? UIImage())
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                            
                            Text(event.name)
                                .font(.caption)
                                .padding(5)
                                .background(Color.white)
                                .cornerRadius(5)
                                .shadow(radius: 5)
                        }
                        .onTapGesture {
                            selectedEvent = event
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onChange(of: region.span) { newSpan in
                    let zoomLevelThreshold: Double = 0.05
                    
                    shouldShowAnnotations = newSpan.latitudeDelta < zoomLevelThreshold && newSpan.longitudeDelta < zoomLevelThreshold
                }
                
                Text(label)
                    .font(.headline)
                    .padding(8)
                    .background(Color.blue.opacity(0.7))
                    .cornerRadius(8)
                    .padding(16)
                    .shadow(radius: 5)
                    .foregroundStyle(Color.white)
            }
        }
    }
}

#Preview {
    @Previewable @State var loggedIn: Bool = true
    MapView(loggedIn: $loggedIn, coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0), label: "Event Locations")
}
