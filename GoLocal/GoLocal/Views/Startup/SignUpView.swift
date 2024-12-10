import SwiftUI

struct SignUpView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showingAlert: Bool = false
    @State private var alertText: String = ""
    @Binding var loggedIn: Bool
    
    var body: some View {
        VStack {
            Text("Sign Up")
                .font(.largeTitle)
                .padding(.top, 20)
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("First Name")
                    .font(.headline)
                    .foregroundColor(.gray)
                TextField("Enter your first name", text: $firstName)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            }
            .padding()

            VStack(alignment: .leading) {
                Text("Last Name")
                    .font(.headline)
                    .foregroundColor(.gray)
                TextField("Enter your last name", text: $lastName)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            }
            .padding()

            VStack(alignment: .leading) {
                Text("Email")
                    .font(.headline)
                    .foregroundColor(.gray)
                TextField("Enter your email", text: $email)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    .autocorrectionDisabled(true)  // Disable autocorrection
                    .keyboardType(.emailAddress)  // Set keyboard type to email
                    .textInputAutocapitalization(.never)  // Ensure no capitalization
            }
            .padding()

            VStack(alignment: .leading) {
                Text("Password")
                    .font(.headline)
                    .foregroundColor(.gray)
                SecureInputView("Enter your password", text: $password)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            }
            .padding()

            VStack(alignment: .leading) {
                Text("Confirm Password")
                    .font(.headline)
                    .foregroundColor(.gray)
                SecureInputView("Confirm your password", text: $confirmPassword)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            }
            .padding()

            Button(action: {
                SignIn()
            }) {
                Text("Sign Up")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(16)
            }
            .padding(.top, 20)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Could not log in"), message: Text(alertText), dismissButton: .default(Text("Got it!")))
            }
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Sign Up", displayMode: .inline)
    }
    
    func SignIn() {
        let passwordHash = hash(data: password.data(using: .utf8)!)

        let usersFiltered: [User] = users.filter { $0.email == email }
        
        guard password == confirmPassword else {
            showingAlert = true
            alertText = "Passwords don't match"
            return
        }
        
        guard isValidEmail(email) else {
            showingAlert = true
            alertText = "Wrong email format"
            return
        }
        
        guard isValidPassword(password: password) else {
            showingAlert = true
            alertText = "Password too short"
            return
        }

        if usersFiltered.count == 0
        {
            loggedIn = true
            let newUser: User = User(id: GetNextUserID(), name: firstName, surname: lastName, email: email, passwordHash: passwordHash)
            user = newUser
            users.append(newUser)
            print("Success!")
                        
            return
        }
        
        showingAlert = true
        alertText = "User already exists. Please log in instead."
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(password: String) -> Bool {
        return password.count >= 8
    }
}
