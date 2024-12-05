//
//  CreateEventView.swift
//  GoLocal
//
//  Created by stud on 28/11/2024.
//


import SwiftUI

struct CreateEventView: View {
    @Binding var isPresented: Bool
    
    @State private var eventName: String = ""
    @State private var eventDescription: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date? = nil 
    @State private var location: Location = mockLocation
    @State private var eventImage: UIImage? = nil
    @State private var latitudeString: String = ""
    @State private var longitudeString: String = ""

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

                        TextField("City", text: $location.city)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        TextField("Country", text: $location.country)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        TextField("Street Name", text: $location.streetName)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        TextField("House ID", text: $location.houseId)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Coordinates (Latitude, Longitude):")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.bottom, 5)

                        TextField("Latitude", text: $latitudeString)
                                                    .padding()
                                                    .keyboardType(.decimalPad)
                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .onChange(of: latitudeString) { newValue in
                                                        latitudeString = filterInput(newValue)
                                                    }

                                                TextField("Longitude", text: $longitudeString)
                                                    .padding()
                                                    .keyboardType(.decimalPad)
                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .onChange(of: longitudeString) { newValue in
                                                        longitudeString = filterInput(newValue)
                                                    }
                    }
                    .padding()

                    VStack(alignment: .leading) {
                        Text("Event Image (Optional):")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.bottom, 5)

                        Button(action: {
                            // For now, just simulating an image selection
                            eventImage = UIImage(systemName: "photo") // Example placeholder image
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

                    HStack {
                        Button("Save Event") {
                            saveEvent()
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)

                        Spacer()

                        Button("Cancel") {
                            isPresented = false
                        }
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    .padding()
                }
                .padding()
                .navigationBarItems(trailing: Button("Close") {
                    isPresented = false
                })
            }            
        }
    }
    
    func filterInput(_ input: String) -> String {
        return input.filter { "0123456789.".contains($0) }
    }
    
    func saveEvent() {
        guard !eventName.isEmpty, !eventDescription.isEmpty, location.valid else {
            print("Error: Missing required fields.")
            return
        }
              
        let currentDate = Date()
        guard startDate >= currentDate else {
            print("Error: Start date cannot be in the past.")
            return
        }
        
        if endDate != nil
        {
            guard let endDate = endDate, endDate >= startDate else {
                print("Error: End date cannot be earlier than the start date.")
                return
            }
                        
            guard endDate >= currentDate else {
                print("Error: End date cannot be earlier than the current date.")
                return
            }
        }
        
        guard let latitude = Double(latitudeString), let longitude = Double(longitudeString) else {
            print("Error: Invalid coordinates.")
            return
        }

        let coordinates = Location.Coordinates(latitude: latitude, longitude: longitude)
        location.coordinates = coordinates
        
        let newEvent = Event(id: GetNextEventID(), name: eventName, startDate: startDate, endDate: endDate, description: eventDescription, ownerId: user.id, imageName: eventImage!.description, category: "", location: location)
        
        print("New event created: \(newEvent)")

        isPresented = false
    }
}

#Preview {
    CreateEventView(isPresented: .constant(true))
}
