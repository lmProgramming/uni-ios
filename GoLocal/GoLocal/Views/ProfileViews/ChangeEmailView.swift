//
//  ChangeEmailView.swift
//  GoLocal
//
//  Created by stud on 28/11/2024.
//


import SwiftUI

struct ChangeEmailView: View {
    @State private var newEmail: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter New Email", text: $newEmail)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Save") {
                saveEmail()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Change Email")
    }
    
    func saveEmail() {
        user.email = newEmail
        print("Email updated to \(newEmail)")
    }
}

#Preview {
    ChangeEmailView()
}
