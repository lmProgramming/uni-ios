//
//  ContentView.swift
//  Landmarks
//
//  Created by stud on 15/10/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var loggedIn = false
    @Query private var items: [Item]

    var body: some View {        
        if loggedIn
        {
            EventList()
        }
        else
        {
            StartPage(loggedIn: $loggedIn)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
