//
//  VotesList.swift
//  GoLocal
//
//  Created by stud on 07/11/2024.
//

import SwiftUI

struct VotesList: View {
    @State private var searchText = ""
    @State private var searchIsActive = false
    private let votePageTitle = NSLocalizedString("votes", comment: "")

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(searchResults) { vote in
                            VStack {
                                if let relatedEvent = findRelatedEvent(vote: vote) {
                                    NavigationLink(destination: EventDetail(event: relatedEvent)) {
                                        VoteRow(vote: vote)
                                            .padding()
                                            .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
                                    }
                                    .padding(.vertical, 4)
                                }
                            }
                        }
                    }
                }
                .navigationTitle(votePageTitle).foregroundColor(.black)
                .searchable(text: $searchText, isPresented: $searchIsActive)
                
                Spacer()
                
                BottomTabBar(selected: 1)
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
