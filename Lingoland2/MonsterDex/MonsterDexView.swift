import SwiftUI

struct MonsterDexView: View {
    @Binding var defeatedMonsters: [Bool]  // Binding to track defeat status

    let monsterNames = ["Squirtle", "Charmander", "Bulbasaur"]

    var body: some View {
        VStack {
            Text("MonsterDex")
                .font(.title)
                .bold()
                .padding()

            // Display the monster dex
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 20) {
                ForEach(0..<monsterNames.count, id: \.self) { index in
                    VStack {
                        // Show the image only for defeated monsters
                        if defeatedMonsters[index] {
                            Image(monsterNames[index])
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())
                        } else {
                            // If the monster is not defeated, display a placeholder or leave it empty
                            Color.clear.frame(width: 70, height: 70) // Placeholder
                        }

                        // Display the monster's name
                        Text(monsterNames[index])
                            .font(.subheadline)
                    }
                    .padding()
                    .background(defeatedMonsters[index] ? Color.orange : Color.gray.opacity(0.2)) // Change background color based on status
                    .cornerRadius(10)
                }
            }
            .padding()
        }
        .onAppear {
            // Force reload the latest status from UserDefaults
            if let savedMonsters = UserDefaults.standard.array(forKey: "defeatedMonsters") as? [Bool] {
                defeatedMonsters = savedMonsters  // Update UI to reflect the latest status
            }
        }
    }
}

struct MonsterDexView_Previews: PreviewProvider {
    @State static var defeatedMonsters = [false, false, false]
    static var previews: some View {
        MonsterDexView(defeatedMonsters: $defeatedMonsters)
    }
}

