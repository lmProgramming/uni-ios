//
//  LandmarkDetail.swift
//  Landmarks
//
//  Created by stud on 15/10/2024.
//

import SwiftUI

struct EventDetail: View {
    var event: Event
    
    var body: some View {
        ScrollView {
            MapView(coordinate: event.location.locationCoordinate, label: event.location.description).frame(height: 300)
            
            CircleImage(image: event.image)
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                Text(event.name).font(.title).foregroundStyle(.black)
                HStack {
                    Text("Starts on " + dateFormatter.string(from: event.startDate) +
                         (event.endDate == nil ? "" :
                         "\nEnds on " + dateFormatter.string(from: event.endDate!)))
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
                
                Text(event.location.description).font(.subheadline)
                Divider()
                
                Text("about")
                    .font(.title2)
                Text(event.description)
            }
            .padding()
            
            Spacer()
            
            let relatedVotes = findRelatedVotes;
            if !relatedVotes.isEmpty
            {
                NavigationSplitView {
                    List(findRelatedVotes) { vote in
                        NavigationLink {
                            VoteDetail(vote: vote)
                        } label: {
                            Text("Vote ID: \(vote.id)")
                        }
                    }
                    .navigationTitle("Votings").multilineTextAlignment(.center)
                } detail: {
                    Text("Related votings")
                }
            }
        }
        .navigationTitle(event.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var findRelatedVotes: [Vote] {
        return votes.filter { $0.eventId == event.id }
    }
}

#Preview {
    EventDetail(event: events[0])
}
