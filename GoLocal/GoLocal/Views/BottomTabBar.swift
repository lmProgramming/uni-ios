import SwiftUI
import CoreLocation

struct BottomTabBar: View {
    @Binding var selected: Int
    @Binding var loggedIn: Bool

    var body: some View {
        HStack {
            MenuButton(iconName: "list.dash", description: "Events", nextView: EventList(), selected: selected == 0)
            
            MenuButton(iconName: "square.and.pencil", description: "Votes", nextView: VotesList(), selected: selected == 1)
            
            MenuButton(iconName: "map", description: "Map", nextView: MapView(coordinate: coordinateCur, label: "Your location"), selected: selected == 2)
            
            MenuButton(iconName: "person.circle", description: "Profile", nextView: ProfileView(loggedIn: $loggedIn), selected: selected == 3)
        }
        .frame(maxWidth: .infinity)
        .background()
    }
    
    var coordinateCur: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: 51.1079, longitude: 17.0385)
    }
}

#Preview {
    @State var loggedIn = false
    BottomTabBar(selected: 0, loggedIn: $loggedIn)
}
