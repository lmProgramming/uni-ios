import SwiftUI

struct EventRow: View {
    var event: Event
    
    var body: some View {
        HStack {
            CircleImage(image: event.image, size: 50, strokeSize: 2, shadowRadius: 2)
            Text(event.name)
        }
    }
}

#Preview("Turtle Rock") {
    EventRow(event: events[0])
}
