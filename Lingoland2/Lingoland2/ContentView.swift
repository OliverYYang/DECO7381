
import SwiftUI

struct ContentView: View {
    @State private var searchText: String = "" // 声明 searchText

    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                HStack {
                    TextField("Search...", text: $searchText)
                        .padding(.leading, 10)
                    NavigationLink(destination: VocabularyView(wordToTranslate: searchText)) {
                        Image(systemName: "magnifyingglass")
                            .padding(.trailing, 10)
                    }
                }
                .frame(height: 40)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding()

                // Profile and Mission Section
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image("Ash") // Replace with actual image name
                            .resizable()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                        VStack(alignment: .leading) {
                            Text("ID: Ash")
                                .font(.headline)
                            Text("Today's Mission: 8 / 10 words")
                                .font(.subheadline)
                        }
                        .foregroundColor(.white)
                        Spacer()
                        Text("Cost: 90")
                            .foregroundColor(.orange)
                            .font(.subheadline)
                            .padding(.trailing)
                    }
                    
                    // Adding the Charmander Image above the button
                    VStack{
                        Image("Charmander") // Replace with the actual image name
                            .resizable()
                            .frame(width: 100, height: 100 )
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)// Adjust size as needed
                            .padding(.bottom, 10) // Overlap slightly with the button
                    }
                    

                    // Catch Mission Button
                    Button(action: {
                        // Action for Catch Button
                    }) {
                        Text("Master! Let's Catch Squirtle!")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .cornerRadius(8)
                    }

                    // Select Target Button
                    Button(action: {
                        // Action for Select Target
                    }) {
                        Text("Select your Target")
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    }
                }
                .padding()
                .background(Color.black.opacity(0.8))
                .cornerRadius(10)
                .padding()

                // Manage Vocabulary and Monster Section
                HStack {
                    VStack {
                        Image("Book")
                            .resizable()
                            .frame(width: 85, height: 65)
                        Spacer()
                        Text("Manage my Vocabulary")
                            .foregroundColor(.white)
                            .font(.footnote)
                    }
                    .background(Color.black.opacity(0.7))
                    .frame(maxWidth: .infinity)

                    VStack {
                        Image("Pokeball")
                            .resizable()
                            .frame(width: 100, height: 73)
                        Text("Manage my Monster")
                            .foregroundColor(.white)
                            .font(.footnote)
                    }
                    .background(Color.black.opacity(0.7))
                    .frame(maxWidth: .infinity)
                }
                .padding()

                Spacer()

                // Bottom Navigation
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
                    // 修改过---------------------------
                    VStack {
                        NavigationLink(destination: ScannerView()) {
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
                        Image(systemName: "gear")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                        Text("Setting")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                .padding()
                .background(Color.black.opacity(0.8))
            }
            .navigationTitle("HomePage")
            .navigationBarTitleDisplayMode(.inline)
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
