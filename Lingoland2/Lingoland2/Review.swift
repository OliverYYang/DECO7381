import SwiftUI

struct ReviewImageView: View {
    var body: some View {
        VStack {
            Image("Review") // Ensure the image name is "Review"
                .resizable()
                .scaledToFit() // Maintain aspect ratio
                .frame(maxWidth: .infinity, maxHeight: .infinity) // Fit the screen size
                .background(Color.black.opacity(0.8)) // Add background color
        }
        .navigationBarTitle("Review Image", displayMode: .inline)
    }
}

