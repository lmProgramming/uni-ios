import SwiftUI

struct ChangeUsernameView: View {
    @State private var newUsername: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter New Username", text: $newUsername)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Save") {
                saveUsername()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Change Username")
    }
    
    func saveUsername() {
        user.name = newUsername
        print("Username updated to \(newUsername)")
    }
}

#Preview {
    ChangeUsernameView()
}
