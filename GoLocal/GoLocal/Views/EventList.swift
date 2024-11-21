import SwiftUI

struct EventList: View {
    @State private var searchText = ""
    @State private var searchIsActive = false
    private let eventPageTitle = NSLocalizedString("events", comment: "").capitalized

    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    List(searchResults) { event in
                        NavigationLink {
                            EventDetail(event: event)
                        } label: {
                            EventRow(event: event)
                        }
                    }
                    .navigationTitle(eventPageTitle)
                    .searchable(text: $searchText, isPresented: $searchIsActive)
                }
                .navigationTitle(eventPageTitle)
                
                Spacer()
                
                BottomTabBar(selected: 0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
        }
    }
    
    var searchResults: [Event] {
        print(events.count)
        if searchText.isEmpty {
            return events
        } else {
            return events.filter { $0.name.contains(searchText) }
        }
    }
}

#Preview {
    EventList()
}
