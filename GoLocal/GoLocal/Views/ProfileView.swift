import SwiftUI
import UserNotifications

struct ProfileView: View {
    private let profilePageTitle = NSLocalizedString("hello", comment: "").capitalized
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @AppStorage("selectedLanguage") private var selectedLanguage = "English"
    
    @State private var allowNotifications = false
    @State private var allowGps = false
    
    @State private var isLogOutAlertPresented = false
    @State private var isDeleteAccountAlertPresented = false
    
    @Binding var loggedIn: Bool
    
    @StateObject private var locationManager = LocationManager()

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
                    .onChange(of: isDarkMode) { newValue in }

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
                    .onChange(of: allowNotifications) { newValue in
                        if newValue {
                            requestNotificationPermission()
                        }
                    }

                    Toggle(isOn: $allowGps) {
                        Text("Allow GPS")
                            .onChange(of: allowGps) { newValue in
                                if newValue {
                                    locationManager.requestLocationPermission()
                                    locationManager.startTrackingLocation()
                                } else {
                                    locationManager.stopTrackingLocation()
                                }
                            }
                    }

                    Button("Send Test Notification") {
                        sendTestNotification()
                    }
                    .disabled(!allowNotifications)
                    .padding()
                    .background(allowNotifications ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)

                    Spacer()
                    Spacer()
                    
                    Button("Log Out") {
                        isLogOutAlertPresented = true
                    }
                    .foregroundColor(.red)
                    .alert(isPresented: $isLogOutAlertPresented) {
                        Alert(title: Text("Are you sure?"),
                              message: Text("Do you really want to log out?"),
                              primaryButton: .destructive(Text("Log Out"), action: {
                                  logOut()
                              }),
                              secondaryButton: .cancel())
                    }
                }
                .navigationTitle(profilePageTitle + ", " + user.name)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background()
                .preferredColorScheme(isDarkMode ? .dark : .light)
                
                Spacer()
                
                BottomTabBar(loggedIn: $loggedIn, selected: 3)
            }
        }
    }
    
    func changeLanguage(to language: String) {
        UserDefaults.standard.set([language], forKey: "AppleLanguages")
    }

    func logOut() {
        loggedIn = false
    }
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted")
            } else {
                print("Notification permission denied")
            }
        }
    }

    func sendTestNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Test Notification"
        content.body = "This is a test notification."
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: "testNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Test notification scheduled.")
            }
        }
    }
}

#Preview {
    @Previewable @State var loggedIn: Bool = true
    ProfileView(loggedIn: $loggedIn)
}
