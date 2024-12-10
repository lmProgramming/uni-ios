import SwiftUI

struct ChangePasswordView: View {
    @State private var newPassword: String = ""
    
    var body: some View {
        VStack {
            SecureField("Enter New Password", text: $newPassword)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Save") {
                savePassword()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Change Password")
    }
    
    func savePassword() {
        user.passwordHash = hash(data: newPassword.data(using: .utf8)!)
        print("Password updated")
    }
}

#Preview {
    ChangePasswordView()
}
