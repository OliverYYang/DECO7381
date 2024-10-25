import SwiftUI
// Top search bar component
struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
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
        .cornerRadius(25)
        .padding(.horizontal)
    }
}

// User info card component
struct UserInfoCardView: View {
    var body: some View {
        HStack {
            Image("Ash")
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text("ID: Ash")
                    .font(.headline)
                Text("Today's Mission:")
                Text("8/10")
                    .font(.subheadline)
            }
            .foregroundColor(.white)
            Spacer()
            Text("Cost: 90")
                .foregroundColor(.orange)
                .font(.subheadline)
                .padding(.trailing)
        }
    }
}

// Bottom navigation bar component
struct BottomNavBarView: View {
    var body: some View {
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

            // Modified to NavigationLink to navigate to SettingView
            VStack {
                NavigationLink(destination: SettingView()) { // Navigate to SettingView
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
}

// Main content view
struct ContentView: View {
    @State private var searchText: String = ""
    @State private var defeatedMonsters: [Bool] = [false, false, false] // Define monster defeat states
    
    var body: some View {
        NavigationView {
            VStack {
                // Top search bar
                SearchBarView(searchText: $searchText)
                
                // User info and tasks
                VStack(alignment: .leading, spacing: 10) {
                    UserInfoCardView()
                    Spacer()
                    
                    // Battle and monster section
                    ZStack {
                        NavigationLink(destination: GameView()) {
                            Text("Master!                                      Let's Catch                               Squirtle!")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: 400, minHeight: 180)
                                .background(Color.orange)
                                .cornerRadius(8)
                        }
                        
                        // Charmander image
                        Image("Charmander") // Replace with the actual image name
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .offset(y: -100)
                    }
                    
                    Spacer()
                    
                    // Select target button
                    NavigationLink(destination: GameView3()) {
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
                .frame(maxWidth: .infinity, minHeight: 400)
                .background(Color.black.opacity(0.8))
                .cornerRadius(10)
                .padding()
                
                Spacer()
                
                // Vocabulary and monster management section
                HStack {
                    NavigationLink(destination: WordView()) {
                        VStack {
                            Image("Book")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 85, height: 85)
                            Text("Manage my Vocabulary")
                                .foregroundColor(.white)
                                .font(.footnote)
                        }
                    }
                    .frame(width: 150, height: 120)
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(10)
                    .padding()

                    NavigationLink(destination: MonsterDexView(defeatedMonsters: $defeatedMonsters)) {
                        VStack {
                            Image("Pokeball")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120, height: 85)
                            Text("Manage my Monster")
                                .foregroundColor(.white)
                                .font(.footnote)
                        }
                    }
                    .frame(width: 150, height: 120)
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(10)
                    .padding()
                }

                Spacer()
                
                // Bottom navigation bar
                BottomNavBarView()
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if let savedMonsters = UserDefaults.standard.array(forKey: "defeatedMonsters") as? [Bool] {
                    defeatedMonsters = savedMonsters
                }
            }
        }
    }
    
    // Reset function
    func resetDefeatedMonsters() {
        UserDefaults.standard.removeObject(forKey: "defeatedMonsters")
        defeatedMonsters = [false, false, false]
        UserDefaults.standard.set(defeatedMonsters, forKey: "defeatedMonsters")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


