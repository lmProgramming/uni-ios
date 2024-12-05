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
                
                TextField("Enter vote question", text: $voteQuestion)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                VStack(alignment: .leading) {
                    Text("Select Related Event:")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.bottom, 5)
                    
                    Picker("Select Event", selection: $selectedEvent) {
                        ForEach(findUserEvents(userId: user.id), id: \.id) { event in
                            Text(event.name)
                                .tag(event as Event?)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
                }
                .padding()

                VStack(alignment: .leading) {
                    Text("Select End Date:")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.bottom, 5)
                    
                    DatePicker("End Date", selection: $endDate, displayedComponents: [.date, .hourAndMinute])
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
                }
                .padding()

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
                        voteOptions.append("")
                    }) {
                        Text("Add Option")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                    .padding(.top, 5)
                }
                .padding()

                HStack {
                    Button("Save Vote") {
                        saveVote()
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
    
    func saveVote() {
        guard let selectedEvent = selectedEvent, !voteQuestion.isEmpty, !voteOptions.isEmpty else {
            print("Error: Missing event, vote question, or options.")
            return
        }
        
        let votingAnswerOptions = voteOptions.map { VotingAnswerOption(id: GetNextVoteID(), answer: $0, amount: 0) }
        
        let newVote = Vote(id: GetNextVoteID(), eventId: selectedEvent.id, question: voteQuestion, endDate: endDate, options: votingAnswerOptions)
        
        print("New vote created: \(newVote)")
        
        votes.append(newVote)
        
        isPresented = false
    }
}

#Preview {
    CreateVoteView(isPresented: .constant(true))
}
