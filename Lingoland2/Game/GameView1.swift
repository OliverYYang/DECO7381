import SwiftUI

struct GameView1: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                VStack(spacing:3) {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image("Ash") // Replace with actual image name
                                .resizable()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                            VStack(alignment: .leading) {
                                Text("ID: Ash")
                                    .font(.headline)
                                    .foregroundColor(.white) // Use white font color
                                Text("Today's Mission: 10 / 10 words")
                                    .font(.subheadline)
                                    .foregroundColor(.white) // Use white font color
                            }
                            Spacer()
                            Text("Cost: 91")
                                .font(.subheadline)
                                .foregroundColor(.orange)
                                .padding(.trailing)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)

                    // Current monster status section
                    VStack(spacing: 20) {
                        Text("Current monster in battle")
                            .font(.headline)
                            .foregroundColor(.white)

                        Text("Charmander")
                            .font(.title)
                            .foregroundColor(.orange)

                        Image("Charmander") // Replace with actual image name
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)

                        // Monster status
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Text("Lv 6: Exp: 5 / 10")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                Spacer()
                                Button(action: {
                                    // Action to increase experience points
                                }) {
                                    Text("Exp+1 by Cost 1")
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .padding(5)
                                        .background(Color.gray)
                                        .cornerRadius(8)
                                }
                            }

                            ProgressView(value: 0.5)
                                .progressViewStyle(LinearProgressViewStyle(tint: Color.orange))

                            Text("Atk: 4  Hp: 103 (+3)")
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.black) // Black background for the monster status container
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)

                    // Evolution button
                    Button(action: {
                        // Evolution action
                    }) {
                        Text("Level up to 10 to Evolve")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)

                    // Switch monster button
                    Button(action: {
                        // Action to switch monster
                    }) {
                        HStack {
                            Image(systemName: "gamecontroller.fill")
                                .foregroundColor(.white)
                            Text("Switch monster for battle")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray)
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                .padding() // Inner padding for the container
                .background(Color.black) // Black background for the entire container
                .cornerRadius(15)
                .padding(.horizontal)

                Spacer()

                // Bottom navigation bar remains unchanged
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
                    // Modified section---------------------------
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
            .navigationTitle("Game")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct GameView1_Previews: PreviewProvider {
    static var previews: some View {
        GameView1()
    }
}

