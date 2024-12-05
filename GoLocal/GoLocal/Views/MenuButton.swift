import SwiftUI

struct MenuButton<Destination: View>: View {
    let iconName: String
    let description: String
    let nextView: Destination
    let selected: Bool
    
    var body: some View {
        let color: Color = selected ? .blue : .gray
        NavigationLink(destination: nextView
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true) 
        ) {
            VStack {
                Image(systemName: iconName)
                    .font(.system(size: 30))
                    .frame(height: 30) 
                
                Text(description)
                    .font(.caption)
                    .lineLimit(1) 
            }
            .foregroundColor(color) 
            .frame(maxWidth: .infinity)
            .padding(.top, 5)
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
