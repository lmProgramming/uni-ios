//
//  MapView.swift
//  Landmarks
//
//  Created by stud on 15/10/2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    var coordinate: CLLocationCoordinate2D
    var label: String
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: .topTrailing) {
                    Map(position: .constant(.region(region))) // Your Map view
                    
                    // Adding a label at the top right
                    Text(label)
                        .font(.headline)
                        .padding(8)
                        .background(Color.blue.opacity(0.7)) // Background for better visibility
                        .cornerRadius(8)
                        .padding(16) // Padding from the edges
                        .shadow(radius: 5) // Optional shadow for better visibility
                        .foregroundStyle(Color.white)
                }
                
                Spacer()
                
                BottomTabBar(selected: 2)
            }
            .navigationTitle("Map")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
        }
    }
    
    private var region: MKCoordinateRegion{
        MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    }
}

#Preview {
    MapView(coordinate: events[0].location.locationCoordinate, label: "Some label")
}
