//
//  ProfileView.swift
//  GoLocal
//
//  Created by stud on 21/11/2024.
//

import SwiftUI

struct ProfileView: View {
    private let profilePageTitle = NSLocalizedString("hello", comment: "").capitalized
    
    var body: some View {
        NavigationView {
            VStack() {
                Text("hello")
                
                Spacer()
                
                BottomTabBar(selected: 3)
            }
            .navigationTitle(profilePageTitle + ", " + user.name)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background()
    }
}

#Preview {
    ProfileView()
}
