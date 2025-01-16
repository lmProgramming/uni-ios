import SwiftUI

struct CircleImage: View {
    var image: Image
    var size: CGFloat = 200
    var strokeSize: CGFloat = 4
    var shadowRadius: CGFloat = 7
    
    var body: some View {
        image
            .resizable()
            .scaledToFill()
            .frame(width: size, height: size)
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: strokeSize)
            }
            .shadow(radius: shadowRadius)
    }
}

#Preview {
    CircleImage(image: Image("turtlerock"))
}
