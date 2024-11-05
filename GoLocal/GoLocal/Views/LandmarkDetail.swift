//
//  LandmarkDetail.swift
//  Landmarks
//
//  Created by stud on 15/10/2024.
//

import SwiftUI

struct LandmarkDetail: View {
    var event: Event
    
    var body: some View {
        ScrollView {
            MapView(coordinate: event.location.locationCoordinate).frame(height: 300)
            
            CircleImage(image: event.image)
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                Text(event.name).font(.title).foregroundStyle(.black)
                HStack {
                    Text(event.location.description).font(.subheadline)
                    Spacer()
                    Text("Zabrze").font(.subheadline)
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
                
                Divider()
                
                Text("About:")
                    .font(.title2)
                Text(event.description)
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle(event.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    LandmarkDetail(event: landmarks[0])
}
