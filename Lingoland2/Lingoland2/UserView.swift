import SwiftUI

struct UserView: View {
    @Environment(\.presentationMode) var presentationMode // Get environment variable to control view presentation
    @State private var showWordView = false // Control the display state of WordView
    @State private var showReviewView = false // Control the display state of ReviewImageView

    
    var body: some View {
        VStack {
            // Custom top container
            HStack {
                Button(action: {
                    // Go back to the previous view
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.white)
                }
                .padding(.leading) // Align the back button to the left
                
                Spacer()
                
                Text("User")
                    .font(.title3)
                    .foregroundColor(.white)
                    .bold() // Center the title
                
                Spacer()
            }
            .padding() // Add padding to the top container
            .background(Color.black.opacity(0.8)) // Set background color to black with some transparency
            
            Spacer() // Placeholder to separate top container from content
            
            // Other content here, such as Profile information
            VStack {
                // Profile 1: Child
                HStack {
                    Image("Ash") // Replace with the actual image name
                        .resizable()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text("Level:")
                            .font(.headline)
                        Text("Child")
                            .font(.subheadline)
                    }
                    
                    Spacer()
                    VStack {
                        Button(action: {
                            showWordView = true
                        }) {
                            Text("Set Daily Task")
                                .padding()
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .background(
                            NavigationLink(destination: WordView(viewModel: WordViewModel()), isActive: $showWordView) {
                                EmptyView()
                            }
                        )
                        
                        Button(action: {
                            // Action for Clear Game Data
                        }) {
                            Text("Clear Game Data")
                                .padding()
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 5)
                .padding(.horizontal)

                // Profile 2: Parent
                HStack {
                    Image("Parent") // Replace with the actual image name
                        .resizable()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text("Level:")
                            .font(.headline)
                        Text("Parent")
                            .font(.subheadline)
                    }
                    
                    Spacer()
                    
                    VStack {
                        Button(action: {
                            showWordView = true
                        }) {
                            Text("Set Daily Task")
                                .padding()
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .background(
                            NavigationLink(destination: WordView(viewModel: WordViewModel()), isActive: $showWordView) {
                                EmptyView()
                            }
                        )
                        
                        Button(action: {
                            showReviewView = true // Set to true to show ReviewImageView
                            // Action for Learning Situation
                        }) {
                            Text("Review situation")
                                .padding()
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .background(
                            NavigationLink(destination: ReviewImageView(), isActive: $showReviewView) {
                                EmptyView()
                            }
                        )

                        Button(action: {
                            // Action for Change Password
                        }) {
                            Text("Change PWS")
                                .padding()
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        
                        Button(action: {
                            // Action for Delete Account
                        }) {
                            Text("DEL Account")
                                .padding()
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 5)
                .padding(.horizontal)

                Spacer()
                
                // Floating Action Button
                HStack {
                    Button(action: {
                        // Action for the floating button
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.orange)
                            .padding()
                    }
                }
                .padding(.trailing)
                Spacer()
                
                // Bottom navigation bar
                HStack {
                    Spacer()
                    VStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                        Text("User")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }
                    Spacer()

                    VStack {
                        NavigationLink(destination: ScannerContentView()) {
                            Image("Scan")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .foregroundColor(.white)
                        }
                        Text("Scan")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }
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
                .background(Color.black.opacity(0.8))
            }
            .navigationBarHidden(true) // Hide the original navigation bar
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}

