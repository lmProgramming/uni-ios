//
//  LandmarkRow.swift
//  Landmarks
//
//  Created by stud on 15/10/2024.
//

import SwiftUI

struct VoteRow: View {
    var vote: Vote
    
    var body: some View {
        let totalVotesCount = vote.totalVotesCount()
        VStack {
            HStack {
                events.first(where: { $0.id == vote.eventId })?.image
                    .resizable()
                    .frame(width: 50, height: 50)
                Text(vote.question)
            }
            VStack {
                ForEach(vote.options) { option in
                    VoteOption(votingOption: option, totalVotes: totalVotesCount)
                }
            }
        }
    }
}

#Preview("Turtle Rock") {
    Group {
        VoteRow(vote: votes[0])
    }
}
