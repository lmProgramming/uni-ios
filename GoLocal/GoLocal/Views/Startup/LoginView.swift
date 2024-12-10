import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showingAlert: Bool = false
    @Binding var loggedIn: Bool

    var body: some View {
        VStack {
            Text("Log In")
                .font(.largeTitle)
                .padding(.top, 20)

            Spacer()

            VStack(alignment: .leading) {
                Text("Email")
                    .font(.headline)
                    .foregroundColor(.gray)
                TextField("Enter your email", text: $email)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    .autocorrectionDisabled(true)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
            }
            .padding()

            VStack(alignment: .leading) {
                Text("Password")
                    .font(.headline)
                    .foregroundColor(.gray)
                SecureInputView("Enter your password", text: $password)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.none)
            }
            .padding()

            Button(action: {
                login()
            }) {
                Text("Log In")
                    .font(.title)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top, 20)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Could not log in"), message: Text("Something went wrong"), dismissButton: .default(Text("Got it!")))
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Login")
        .navigationBarTitleDisplayMode(.inline)
    }

    func login() {
        let passwordHash = hash(data: password.data(using: .utf8)!)

        let usersFiltered: [User] = users.filter { $0.passwordHash == passwordHash && $0.email == email }

        if usersFiltered.count == 1 {
            loggedIn = true
            print("Success!")
            return
        }
        
        showingAlert = true
    }
}
