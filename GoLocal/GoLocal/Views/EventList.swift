import SwiftUI

struct EventList: View {
    @State private var searchText = ""
    @State private var searchIsActive = false
    private let prompt = NSLocalizedString("sign", comment: "")

    var body: some View {
        NavigationSplitView
        {
            List(searchResults) {
                event in NavigationLink {
                    EventDetail(event: event)
                } label: {
                    EventRow(event: event)
                }
            }
            .navigationTitle(prompt)
            .searchable(text: $searchText, isPresented: $searchIsActive)
        }
        detail: {
            Text(prompt)
        }
    }
    
    var searchResults: [Event] {
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
