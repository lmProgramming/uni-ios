import SwiftUI
import CoreLocation

struct CreateEventView: View {
    @Binding var isPresented: Bool
    
    @State private var eventName: String = ""
    @State private var eventDescription: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date? = nil
    @State private var city: String = ""
    @State private var country: String = ""
    @State private var streetName: String = ""
    @State private var houseId: String = ""
    @State private var eventImage: UIImage? = nil
    @State private var latitudeString: String = ""
    @State private var longitudeString: String = ""
    @State private var categoryIndex: Int = 1
    @State private var showingAlert: Bool = false
    @State private var alertText: String = ""
    
    var geocoder = CLGeocoder()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Create a New Event")
                        .font(.headline)
                        .padding()
                    
                    TextField("Event Name", text: $eventName)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    VStack(alignment: .leading) {
                        Text("Description:")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.bottom, 5)

                        TextEditor(text: $eventDescription)
                            .padding()
                            .frame(height: 150)
                            .border(Color.gray, width: 1)
                            .cornerRadius(8)
                    }
                    .padding()

                    VStack(alignment: .leading) {
                        Text("Start Date:")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.bottom, 5)

                        DatePicker("Start Date", selection: $startDate, displayedComponents: [.date, .hourAndMinute])
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
                    }
                    .padding()

                    VStack(alignment: .leading) {
                        Text("End Date (Optional):")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.bottom, 5)

                        DatePicker(
                            "End Date",
                            selection: Binding(
                                get: { endDate ?? Date() },
                                set: { endDate = $0 }
                            ),
                            displayedComponents: [.date, .hourAndMinute]
                        )
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
                        .opacity(endDate == nil ? 0.5 : 1.0)
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Location Information:")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.bottom, 5)

                        TextField("City", text: $city)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        TextField("Country", text: $country)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        TextField("Street Name", text: $streetName)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        TextField("House ID", text: $houseId)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding()

                    VStack(alignment: .leading) {
                        Text("Event Image (Optional):")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.bottom, 5)

                        Button(action: {
                            eventImage = UIImage(systemName: "photo")
                        }) {
                            HStack {
                                Text(eventImage == nil ? "Select Image" : "Change Image")
                                    .foregroundColor(.blue)
                                Spacer()
                                if let image = eventImage {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                }
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
                        }
                    }
                    .padding()
                    
                    VStack {
                        Text("Choose category:")
                        Picker(selection: $categoryIndex, label: Text("Select Category")) {
                            ForEach(1..<categories.count, id: \.self) {
                                Text(categories[$0])
                            }
                        }
                    }
                    
                    Button("Save Event") {
                        saveEvent()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .padding()
                .navigationBarItems(trailing: Button("Close") {
                    isPresented = false
                })
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Error"), message: Text(alertText), dismissButton: .default(Text("Got it!")))
            }
        }
    }

    func filterInput(_ input: String) -> String {
        return input.filter { "0123456789.".contains($0) }
    }

    func saveEvent() {
        guard !eventName.isEmpty, !eventDescription.isEmpty else {
            print("Error: Missing required fields.")
            return
        }
              
        let currentDate = Date()
        guard startDate >= currentDate else {
            print("Error: Start date cannot be in the past.")
            showingAlert = true
            alertText = "Start date cannot be in the past."
            return
        }

        if endDate != nil {
            guard let endDate = endDate, endDate >= startDate else {
                print("Error: End date cannot be earlier than the start date.")
                showingAlert = true
                alertText = "End date cannot be earlier than the start date."
                return
            }
                        
            guard endDate >= currentDate else {
                print("Error: End date cannot be earlier than the current date.")
                showingAlert = true
                alertText = "End date cannot be earlier than the current date."
                return
            }
        }
        
        let address = "\(streetName), \(city), \(country)"
        
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                self.showingAlert = true
                self.alertText = "Could not geocode address."
                return
            }

            guard let placemark = placemarks?.first, let coordinate = placemark.location?.coordinate else {
                print("Geocoding failed: No coordinates found")
                self.showingAlert = true
                self.alertText = "Could not find coordinates for the location."
                return
            }

            let coordinates = Coordinates(latitude: coordinate.latitude, longitude: coordinate.longitude)
            
            let newEvent = Event(
                id: GetNextEventID(),
                name: eventName,
                startDate: startDate,
                endDate: endDate,
                description: eventDescription,
                ownerId: user.id,
                imageName: eventImage?.description ?? "",
                category: categories[categoryIndex],
                coordinates: coordinates
            )
            
            events.append(newEvent)
            print("New event created: \(newEvent)")

            isPresented = false
        }
    }
}

#Preview {
    CreateEventView(isPresented: .constant(true))
}
