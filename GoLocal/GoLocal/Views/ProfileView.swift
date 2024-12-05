import SwiftUI

struct ProfileView: View {
    private let profilePageTitle = NSLocalizedString("hello", comment: "").capitalized
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    @AppStorage("selectedLanguage") private var selectedLanguage = "English"
    
    @State private var allowNotifications = false
    
    @State private var isLogOutAlertPresented = false
    @State private var isDeleteAccountAlertPresented = false
    
    @Binding var loggedIn: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    NavigationLink(destination: ChangeUsernameView()) {
                        Text("Change Username")
                    }
                    
                    NavigationLink(destination: ChangePasswordView()) {
                        Text("Change Password")
                    }
                    
                    NavigationLink(destination: ChangeEmailView()) {
                        Text("Change Email")
                    }

                    Toggle(isOn: $isDarkMode) {
                                       Text("Dark Mode (experimental)")
                                   }
                                   .onChange(of: isDarkMode) { newValue in
                                   }
                    
                    Picker("Language", selection: $selectedLanguage) {
                        Text("English").tag("English")
                        Text("Polish").tag("Polish")
                    }
                    .pickerStyle(MenuPickerStyle())
                    .onChange(of: selectedLanguage) { newValue in
                        changeLanguage(to: newValue)
                    }
                    
                    Toggle(isOn: $allowNotifications) {
                        Text("Allow Notifications")
                    }

                    Toggle(isOn: .constant(true)) {
                        Text("Allow GPS")
                    }

                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    Button("Log Out") {
                        isLogOutAlertPresented = true
                    }
                    .foregroundColor(.yellow)
                    .alert(isPresented: $isLogOutAlertPresented) {
                        Alert(title: Text("Are you sure?"),
                              message: Text("Do you really want to log out?"),
                              primaryButton: .destructive(Text("Log Out"), action: {
                                  logOut()
                              }),
                              secondaryButton: .cancel())
                    }
                    
                    Button("Delete Account") {
                        isDeleteAccountAlertPresented = true
                    }
                    .foregroundColor(.red)
                    .alert(isPresented: $isDeleteAccountAlertPresented) {
                        Alert(title: Text("Are you sure?"),
                              message: Text("This action is permanent and cannot be undone."),
                              primaryButton: .destructive(Text("Delete Account"), action: {
                                  deleteAccount()
                              }),
                              secondaryButton: .cancel())
                    }
                }
                .navigationTitle(profilePageTitle + ", " + user.name)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background()
                .preferredColorScheme(isDarkMode ? .dark : .light)
                
                Spacer()
                
                BottomTabBar(selected: 3)
            }
        }
    }
    
    func changeLanguage(to language: String) {
        UserDefaults.standard.set([language], forKey: "AppleLanguages")
    }

    func logOut() {
        loggedIn = false
    }
    
    func deleteAccount() {
        loggedIn = false
        if let index = users.firstIndex(of: user) {
            users.remove(at: index)
        }
    }
}

#Preview {
    @Binding var loggedIn: Bool = true
    ProfileView(loggedIn: loggedIn)
}
