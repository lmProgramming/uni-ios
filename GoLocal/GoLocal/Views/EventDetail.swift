import SwiftUI
import CoreLocation

class EventDetailViewModel: ObservableObject {
    @Published var locationText: String? = nil
    @Published var relatedVotes: [Vote] = []
    
    var event: Event
    
    init(event: Event) {
        self.event = event
        fetchLocationText()
        fetchRelatedVotes()
    }
    
    private func fetchLocationText() {
        getLocationFromCoordinates(event.coordinates) { [weak self] address in
            DispatchQueue.main.async {
                self?.locationText = address
            }
        }
    }
    
    private func fetchRelatedVotes() {
        self.relatedVotes = votes.filter { $0.eventId == event.id }
    }
}

struct EventDetail: View {
    @StateObject private var viewModel: EventDetailViewModel
    @State private var showGallery = false
    @State private var selectedImage: Image?
    
    private let startsOnText = NSLocalizedString("starts_on", comment: "").capitalizingFirstLetter()
    private let endsInText = NSLocalizedString("ends_in", comment: "").capitalizingFirstLetter()
    private let organizerText = NSLocalizedString("organizer", comment: "").capitalizingFirstLetter()
    
    init(event: Event) {
        _viewModel = StateObject(wrappedValue: EventDetailViewModel(event: event))
    }
    
    var body: some View {
        ScrollView {
            MapInsideView(coordinate: viewModel.event.cllCoordinates, label: viewModel.locationText ?? "Fetching location...", events: events, eventAlwaysShown: viewModel.event)
                .frame(height: 300)
            
            CircleImage(image: viewModel.event.image)
                .offset(y: -130)
                .padding(.bottom, -130)
                .onTapGesture {
                    showGallery.toggle()
                }
            
            VStack(alignment: .leading) {
                Text(viewModel.event.name).font(.title)
                HStack {
                    Text(startsOnText + " " + dateFormatter.string(from: viewModel.event.startDate) + getEndText)
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
                
                if let locationText = viewModel.locationText {
                    Text(locationText).font(.subheadline)
                } else {
                    Text("Fetching location...").font(.subheadline)
                }
                
                let organizer = users[viewModel.event.ownerId]
                                
                Text(organizerText + ": " + (organizer == user ? " you!" : organizer.signature))
                
                Divider()
                
                Text("about")
                    .font(.title2)
                Text(viewModel.event.description)
            }
            .padding()
            
            Spacer()
            
            Button(action: navigateToLocation) {
                Text("Navigate to")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
            }
            .padding()
            
            if !viewModel.relatedVotes.isEmpty {
                NavigationSplitView {
                    List(viewModel.relatedVotes) { vote in
                        NavigationLink {
                            VoteRow(vote: vote, event: viewModel.event)
                        } label: {
                            Text(String(vote.question))
                        }
                    }
                    .navigationTitle("Votings").multilineTextAlignment(.center)
                } detail: {
                    Text("Related votings")
                }
            }
        }
        .navigationTitle(viewModel.event.name)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showGallery) {
            GalleryView(images: viewModel.event.images)
        }
    }
    
    var getEndText: String {
        return viewModel.event.endDate == nil ? "" : ("\n" + endsInText + " " + dateFormatter.string(from: viewModel.event.endDate!))
    }
    
    private func navigateToLocation() {
        let latitude = viewModel.event.coordinates.latitude
        let longitude = viewModel.event.coordinates.longitude
        let mapURL = URL(string: "maps://?q=\(latitude),\(longitude)")!
        
        if UIApplication.shared.canOpenURL(mapURL) {
            UIApplication.shared.open(mapURL)
        } else {
            print("Cannot open Maps app")
        }
    }
}

#Preview {
    EventDetail(event: events[0])
}
