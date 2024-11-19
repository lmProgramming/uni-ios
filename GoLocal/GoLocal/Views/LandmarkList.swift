//
//  LandmarkList.swift
//  Landmarks
//
//  Created by stud on 15/10/2024.
//

import SwiftUI

struct LandmarkList: View {
    var body: some View {
        NavigationSplitView
        {
            List(landmarks) {
                landmark in NavigationLink {
                    LandmarkDetail(event: landmark)
                } label: {
                    LandmarkRow(landmark: landmark)
                }
            }
            .navigationTitle("Events")
        } detail: {
            Text("Select an event")
        }
    }
}

#Preview {
    LandmarkList()
}
