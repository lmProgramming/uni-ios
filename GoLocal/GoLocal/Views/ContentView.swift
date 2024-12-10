import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var loggedIn = false

    var body: some View {
        VStack {
            if loggedIn {
                EventList(loggedIn: $loggedIn) 
            } else {
                StartPage(loggedIn: $loggedIn)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
