import SwiftUI

struct EventList: View {
    @State private var searchText = ""
    @State private var searchIsActive = false
    @State private var isCreatingNewEvent = false
    @State private var showFilterSheet = false
    @State private var selectedCategory: String = "All"
    @Binding var loggedIn: Bool
    private let eventPageTitle = NSLocalizedString("events", comment: "").capitalized
    
    var body: some View {
        NavigationView {
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
                
                Spacer()
                
                BottomTabBar(loggedIn: $loggedIn, selected: 0)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showFilterSheet.toggle()
                    }) {
                        Text("Filter")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isCreatingNewEvent.toggle()
                    }) {
                        Text("Create New Event")
                    }
                }
            }
            .sheet(isPresented: $showFilterSheet) {
                FilterSheetView(selectedCategory: $selectedCategory)
            }
            .sheet(isPresented: $isCreatingNewEvent) {
                CreateEventView(isPresented: $isCreatingNewEvent)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background()
        }
    }

    var searchResults: [Event] {
        let filteredEvents = events.filter { event in
            selectedCategory == "All" || event.category == selectedCategory
        }
        
        if searchText.isEmpty {
            return filteredEvents
        } else {
            return filteredEvents.filter { $0.name.contains(searchText) }
        }
    }
}

struct FilterSheetView: View {
    @Binding var selectedCategory: String
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Category")) {
                    Picker("Select Category", selection: $selectedCategory) {
                        ForEach(categories, id: \.self) { category in
                            Text(category).tag(category)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
            }
            .navigationTitle("Filters")
            .navigationBarItems(trailing: Button("Done") {
            })
        }
    }
}
