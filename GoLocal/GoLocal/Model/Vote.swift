//
//  Vote.swift
//  GoLocal
//
//  Created by stud on 07/11/2024.
//

import Foundation
import SwiftUI
import CoreLocation

struct VotingAnswerOption: Hashable, Codable, Identifiable {
    var id: Int
    var answer: String
    var amount: Int
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
            sum += options[x].amount
        }
        
        return sum
    }
}

func GetNextVoteID() -> Int {
    return (votes.max(by: { $0.id < $1.id })?.id ?? 0) + 1
}
