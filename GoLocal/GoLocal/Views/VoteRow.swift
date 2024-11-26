//
//  LandmarkRow.swift
//  Landmarks
//
//  Created by stud on 15/10/2024.
//

import SwiftUI

struct VoteRow: View {
    var vote: Vote
    var event: Event
    
    var body: some View {
        VStack {
            VoteRowTop(vote: vote, event: event)
            VoteRowBottom(vote: vote, event: event)
        }
    }
}

struct VoteRowTop: View {
    var vote: Vote
    var event: Event
    
    var body: some View {
        VStack {
            HStack {
                event.image
                    .resizable()
                    .frame(width: 50, height: 50)
                Text(event.name)
            }
            Text(vote.question)
        }
    }
}

struct VoteRowBottom: View {
    var vote: Vote
    var event: Event
    private let endsInText = NSLocalizedString("ends_in", comment: "").capitalizingFirstLetter()
    
    var body: some View {
        let totalVotesCount = vote.totalVotesCount()
        VStack {
            VStack {
                ForEach(vote.options) { option in
                    VoteOption(votingOption: option, totalVotes: totalVotesCount)
                }
            }
            Text(endsInText + " " + dateFormatter.string(from: vote.endDate))
        }
    }
}

#Preview("Turtle Rock") {
    Group {
        VoteRow(vote: votes[0], event: events[0])
    }
}
