import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var loggedIn = false
    @State private var selectedTab = 0
    @Query private var items: [Item]

    var body: some View {
        if loggedIn {
            VStack {
                selectedView

                Spacer()

                BottomTabBar(selected: $selectedTab, loggedIn: $loggedIn)
            }
        } else {
            StartPage(loggedIn: $loggedIn)
        }
    }

    @ViewBuilder
    private var selectedView: some View {
        switch selectedTab {
        case 0:
            EventList()
        case 1:
            VotesList()
        case 2:
            MapView(coordinate: coordinateCur, label: "Your location")
        case 3:
            ProfileView(loggedIn: $loggedIn)
        default:
            EventList()
        }
    }

    private var coordinateCur: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: 51.1079, longitude: 17.0385)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}