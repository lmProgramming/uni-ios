import SwiftUI

struct VoteOption: View {
    @Binding var votingOption: VotingAnswerOption
    var totalVotes: Int
    
    private let voteText = NSLocalizedString("votes_count_descriptor", comment: "")
    
    var body: some View {
        HStack{
            Button(action: {
                votingOption.addVote(userId: user.id)
            }) {
                Text(votingOption.answer)
            }
            .padding()
            .background(votingOption.userVoted(userId: user.id) ? Color.blue : Color.gray )
            .foregroundColor(.white)
            .cornerRadius(8)
            
            let progress: Double = Double(votingOption.voterIds.count) / Double(totalVotes)
            
            VStack{
                Spacer()
                HorizontalProgressBarRepresentable(progress: progress)
                
                Text(String(votingOption.voterIds.count) + " " + voteText)
                Spacer()
            }
        }        
        .frame(height: 65)
    }
}

#Preview {
    @Previewable @State var vote = votes[0]
    VoteOption(votingOption: $vote.options[0], totalVotes: votes[0].totalVotesCount())
}
