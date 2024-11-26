import SwiftUI

struct MenuButton<Destination: View>: View {
    let iconName: String
    let description: String
    let nextView: Destination
    let selected: Bool
    
    var body: some View {
        let color: Color = selected ? .blue : .gray
        NavigationLink(destination: nextView
                        .navigationBarHidden(true) // Hide navigation bar on this view
                        .navigationBarBackButtonHidden(true) // Hide "Back" button
        ) {
            VStack {
                Image(systemName: iconName)
                    .font(.system(size: 30))
                    .frame(height: 30) // Force a height for the icon
                
                Text(description)
                    .font(.caption) // Optional: Adjust the font size if needed
                    .lineLimit(1) // Prevent multiline labels
            }
            .foregroundColor(color) // Set icon and label color
            .frame(maxWidth: .infinity) // Stretch button width to fill the HStack
            .padding(.top, 5) // Add spacing between icon and label (optional)
        }
        .buttonStyle(PlainButtonStyle())
        .background()
    }
}

#if DEBUG
struct MenuButton_Previews: PreviewProvider {
   static var previews: some View {
      Group {
          MenuButton(iconName: "list.dash", description: "Events", nextView: EventList(), selected: true)
            .environment(\.colorScheme, .light)
          MenuButton(iconName: "list.dash", description: "Events", nextView: EventList(), selected: true)
            .environment(\.colorScheme, .dark)
      }
   }
}
#endif
