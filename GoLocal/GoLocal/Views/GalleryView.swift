import SwiftUI

struct GalleryView: View {
    let images: [Image]
    
    var body: some View {
        VStack {
            Text("Image Gallery")
                .font(.headline)
            
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(images.indices, id: \.self) { imageIdx in
                        images[imageIdx]
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                    }
                }
            }
        }
        .padding()
        .navigationTitle("Gallery")
        .navigationBarTitleDisplayMode(.inline)
    }
}
