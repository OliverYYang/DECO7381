import SwiftUI

struct GameView3: View {
    @Environment(\.presentationMode) var presentationMode // Get the environment variable to control view presentation
    @State private var selectedTarget: String = "Bulbasaur"

    var body: some View {
        VStack {

            HStack {
                Button(action: {
                    // Go back to the previous view (in this case, ContentView)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.white)
                }
                .padding(.leading) // Align the back button to the left

                Spacer()

                Text("Game")
                    .font(.title3)
                    .foregroundColor(.white)
                    .bold() // Center the title text

                Spacer()
            }
            .padding() // Add padding to the top container
            .background(Color.black.opacity(0.8)) // Black background

            // Black background container for task info and buttons
            VStack {
                // Task info
                VStack(alignment: .leading) {
                    HStack {
                        Image("Ash") // Replace with actual image name
                            .resizable()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                        VStack(alignment: .leading) {
                            Text("ID: 傻东西") // Display user ID
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("Today's Mission: 10 / 10 words")
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        Spacer()
                        Text("Cost: 91")
                            .foregroundColor(.orange)
                            .font(.headline)
                    }
                    .padding()
                    .padding(.horizontal)
                }
                
                Text("Select your Target!")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.top)
                
                // Grid layout for target selection
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(["Squirtle", "Bulbasaur", "Pichu"], id: \.self) { target in
                        Button(action: {
                            selectedTarget = target // Update the selected target
                        }) {
                            VStack {
                                Image(target) // Replace with actual image name
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                                    .padding()
                                    .background(selectedTarget == target ? Color.orange : Color.white)
                                    .cornerRadius(12)
                                Text(target)
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
                .padding()

                Spacer()

                // Button container
                VStack(spacing: 15) {
                    // Navigate to GameView
                    NavigationLink(destination: GameView()) {
                        Text("Continue to Catch \(selectedTarget)")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: 350)

                    // Return to ContentView
                    Button(action: {
                        presentationMode.wrappedValue.dismiss() // Return to the previous view (ContentView)
                    }) {
                        Text("Back to Homepage")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: 350)
                }
                .padding()
            }
            .background(Color.black.opacity(0.8)) // Black background container
            .cornerRadius(15)
            .padding(.horizontal)

            Spacer()

            // Bottom navigation bar to navigate to UserView and SettingView
            HStack {
                Spacer()
                VStack {
                    NavigationLink(destination: UserView()) {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                    }
                    Text("User")
                        .font(.footnote)
                        .foregroundColor(.white)
                }
                Spacer()

                Spacer()

                VStack {
                    NavigationLink(destination: SettingView()) {
                        Image(systemName: "gear")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                    }
                    Text("Setting")
                        .font(.footnote)
                        .foregroundColor(.white)
                }
                Spacer()
            }
            .padding()
            .background(Color.black.opacity(0.8)) // Keep the bottom navigation bar consistent
        }
        .navigationBarHidden(true) // Hide the original navigation bar
    }
}

struct GameView3_Previews: PreviewProvider {
    static var previews: some View {
        GameView3()
    }
}

