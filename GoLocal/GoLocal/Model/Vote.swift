import Foundation
import SwiftUI
import CoreLocation

struct VotingAnswerOption: Hashable, Codable, Identifiable {
    var id: Int
    var answer: String
    var voterIds: [Int]
    
    mutating func addVote(userId: Int) {
        let index = self.voterIds.firstIndex(of: userId)
        if index != nil {
            self.voterIds.remove(at: index!)
            return
        }
        
        self.voterIds.append(userId)
    }
    
    func userVoted(userId: Int) -> Bool {
        self.voterIds.contains(userId)
    }
}

struct Vote: Hashable, Codable, Identifiable {
    var id: Int
    var eventId: Int
    var question: String
    var endDate: Date
    
    var options: [VotingAnswerOption]
      
    func totalVotesCount() -> Int
    {
        var sum = 0
          
        for x in 0..<options.count{
            sum += options[x].voterIds.count
        }
        
        return sum
    }
}

func GetNextVoteID() -> Int {
    return (votes.max(by: { $0.id < $1.id })?.id ?? 0) + 1
}
