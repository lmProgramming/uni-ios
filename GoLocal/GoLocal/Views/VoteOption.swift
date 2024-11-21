//
//  LandmarkRow.swift
//  Landmarks
//
//  Created by stud on 15/10/2024.
//

import SwiftUI

struct VoteOption: View {
    var votingOption: VotingAnswerOption
    var totalVotes: Int
    
    private let voteText = NSLocalizedString("votes_count_descriptor", comment: "")
    
    var body: some View {
        HStack{
            Spacer()
            Button(action: {
                print("Selected option: \(votingOption.answer)")
            }) {
                Text(votingOption.answer)
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            let progress: Double = Double(votingOption.amount) / Double(totalVotes)
            
            VStack{
                HorizontalProgressBarRepresentable(progress: progress)
                
                Text(String(votingOption.amount) + " " + voteText)
            }
        }
    }
}

#Preview {
    let mockVotes = [
        Vote(id: 1, eventId: 1, question: "Vote on the date", options: [
            VotingAnswerOption(id: 1, answer: "1.12.2024", amount: 112),
            VotingAnswerOption(id: 2, answer: "2.12.2024", amount: 19312)
        ])
    ]
    
    VoteOption(votingOption: mockVotes[0].options[0], totalVotes: mockVotes[0].totalVotesCount())
}
