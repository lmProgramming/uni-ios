import SwiftUI

struct VotesList: View {
    @State private var searchText = ""
    @State private var searchIsActive = false
    @State private var isCreatingNewVote = false
    private let votePageTitle = NSLocalizedString("votes", comment: "")

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(searchResults) { vote in
                            VStack {
                                HStack {
                                    voteRowLink(vote: vote)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
                            }
                        }
                    }
                }
                .navigationTitle(votePageTitle).foregroundColor(.black)
                .searchable(text: $searchText, isPresented: $searchIsActive)
                .padding()
            }
            .toolbar {
                if findUserEvents(userId: user.id).count > 0
                {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isCreatingNewVote.toggle()
                        }) {
                            Text("Create New Vote")
                        }
                    }
                }
            }
            .sheet(isPresented: $isCreatingNewVote) {
                CreateVoteView(isPresented: $isCreatingNewVote)
            }
        }
        .background()
    }
    
    func voteRowLink(vote: Vote) -> some View {
        Group {
            if let relatedEvent = findRelatedEvent(vote: vote) {
                VStack {
                    NavigationLink(destination: EventDetail(event: relatedEvent)) {
                        VoteRowTop(vote: vote, event: relatedEvent)
                    }
                    .padding(.vertical, 4)
                    VoteRowBottom(vote: vote, event: relatedEvent)
                }
            } else {
                EmptyView()
            }
        }
    }
    
    var searchResults: [Vote] {
        if searchText.isEmpty {
            return votes
        } else {
            return votes.filter { $0.question.contains(searchText) }
        }
    }
    
    func findRelatedEvent(vote: Vote) -> Event? {
        return events.first { $0.id == vote.eventId }
    }
}

#Preview {
    VotesList()
}
