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
                CircleImage(image: event.image, size: 50, strokeSize: 2, shadowRadius: 2)
                Text(event.name)
                    .foregroundColor(.primary)
            }
            Text(vote.question)
                .foregroundColor(.primary)
        }
    }
}


struct VoteRowBottom: View {
    @State var vote: Vote
    var event: Event
    private let endsInText = NSLocalizedString("ends_in", comment: "").capitalizingFirstLetter()
    
    var body: some View {
        VStack {
            VStack {
                ForEach(0..<vote.options.count, id: \.self) { index in
                    VoteOption(
                        votingOption: $vote.options[index],
                        totalVotes: vote.totalVotesCount()
                    )
                    .padding(2)
                }
            }
            Text(endsInText + " " + dateFormatter.string(from: vote.endDate))
        }
    }
}

#Preview("Turtle Rock") {
    Group {
        VoteRow(vote: votes[6], event: events[0])
    }
}
