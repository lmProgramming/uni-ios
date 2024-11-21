import SwiftUI
import CoreLocation

struct BottomTabBar: View {
    var selected: Int
    
    var body: some View {
        HStack {
            MenuButton(iconName: "list.dash", description: "Events", nextView: EventList(), selected: selected == 0)
            
            MenuButton(iconName: "checkmark.circle", description: "Votes", nextView: VotesList(), selected: selected == 1)
            
            MenuButton(iconName: "map", description: "Map", nextView: MapView(coordinate: coordinateCur, label: "Your location"), selected: selected == 2)
            
            MenuButton(iconName: "person.circle", description: "Profile", nextView: ProfileView(), selected: selected == 3)
        }
        .frame(maxWidth: .infinity) // Ensure all buttons are evenly spaced
    }
    
    var coordinateCur: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: 51.1079, longitude: 17.0385)
    }
}

#Preview {
    BottomTabBar(selected: 0)
}
