//
//  LandmarkRow.swift
//  Landmarks
//
//  Created by stud on 15/10/2024.
//

import SwiftUI

struct EventRow: View {
    var event: Event
    
    var body: some View {
        HStack {
            event.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(event.name)
        }
    }
}

#Preview("Turtle Rock") {
    EventRow(event: events[0])
}
