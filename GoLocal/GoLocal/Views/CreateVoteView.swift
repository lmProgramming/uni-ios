import SwiftUI

struct CreateVoteView: View {
    @Binding var isPresented: Bool
    
    @State private var voteQuestion: String = "" // Placeholder for the vote question input
    @State private var selectedEvent: Event? = nil // To store the selected event
    @State private var endDate: Date = Date() // To store the selected end date
    @State private var voteOptions: [String] = [""] // List of vote options, with one initial empty option

    var body: some View {
        NavigationView {
            VStack {
                Text("Create a New Vote")
                    .font(.headline)
                    .padding()
                
                // Vote Question TextField
                TextField("Enter vote question", text: $voteQuestion)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                // Event Picker
                VStack(alignment: .leading) {
                    Text("Select Related Event:")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.bottom, 5)
                    
                    Picker("Select Event", selection: $selectedEvent) {
                        ForEach(events, id: \.id) { event in
                            Text(event.name) // Display event names in the Picker
                                .tag(event as Event?) // Tag each event with itself to identify the selection
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
                }
                .padding()

                // End Date Picker
                VStack(alignment: .leading) {
                    Text("Select End Date:")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.bottom, 5)
                    
                    DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
                }
                .padding()

                // Vote Options - dynamic list of text fields
                VStack(alignment: .leading) {
                    Text("Vote Options:")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.bottom, 5)

                    ForEach(0..<voteOptions.count, id: \.self) { index in
                        TextField("Option \(index + 1)", text: $voteOptions[index])
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    Button(action: {
                        // Add a new empty option
                        voteOptions.append("")
                    }) {
                        Text("Add Option")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                    .padding(.top, 5)
                }
                .padding()

                // Action buttons
                HStack {
                    Button("Save Vote") {
                        // Handle saving the vote
                        saveVote()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)

                    Spacer()

                    Button("Cancel") {
                        // Dismiss the modal without saving
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
    
    // This function saves the new vote (you can expand it to handle actual data storage)
    func saveVote() {
        guard let selectedEvent = selectedEvent, !voteQuestion.isEmpty, !voteOptions.isEmpty else {
            // Handle error: either no event selected, vote question empty, or no options provided
            print("Error: Missing event, vote question, or options.")
            return
        }
        
        // Create a list of voting options from the entered text
        let votingAnswerOptions = voteOptions.map { VotingAnswerOption(id: GetNextVoteID(), answer: $0, amount: 0) }
        
        // Create a new vote with the selected event, vote question, end date, and options
        let newVote = Vote(id: GetNextVoteID(), eventId: selectedEvent.id, question: voteQuestion, endDate: endDate, options: votingAnswerOptions)
        
        // Perform the save operation, e.g., add to votes array or save to a database
        print("New vote created: \(newVote)")
        
        votes.append(newVote)
        
        // Dismiss the modal
        isPresented = false
    }
}

// Preview (add sample data for testing)
#Preview {
    CreateVoteView(isPresented: .constant(true))
}
