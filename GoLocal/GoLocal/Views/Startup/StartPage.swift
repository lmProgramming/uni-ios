import SwiftUI

struct StartPage: View {
    @State private var isLoginActive = false
    @State private var isSignUpActive = false
    @Binding var loggedIn: Bool

    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("Welcome to")
                        .font(.system(size: 50, weight: .black))
                    Text("GoLocal!")
                        .font(.system(size: 50, weight: .black))
                }
                .multilineTextAlignment(.center)
                .padding(.top, 70)
                
                Spacer()
                
                NavigationLink(destination: LoginView(loggedIn: $loggedIn), isActive: $isLoginActive) {
                    Button(action: {
                        isLoginActive = true
                    }) {
                        Text("Log In")
                            .font(.title)
                            .frame(maxWidth: 200)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                            .shadow(radius: 5)
                    }
                }
                
                Text("or")
                    .padding(50)
                    .font(.system(size: 30))

                NavigationLink(destination: SignUpView(loggedIn: $loggedIn), isActive: $isSignUpActive) {
                    Button(action: {
                        isSignUpActive = true
                    }) {
                        Text("Sign Up")
                            .font(.title)
                            .frame(maxWidth: 200)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                            .shadow(radius: 5)
                    }
                }
                
                Spacer()
            }
        }
        .background(
            Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        )
    }
}

#Preview {
    @Previewable @State var loggedIn = false
    return StartPage(loggedIn: $loggedIn)
}
