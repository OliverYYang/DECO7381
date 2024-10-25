import SwiftUI

struct GameView: View {
    @State private var monsterHP = 100
    @State private var playerCost = 0
    @State private var playerEXP = 0
    @State private var playerHP = 100
    @State private var charmanderLevel = 1
    @State private var maxHP = 100
    @State private var currentQuestion: String = ""
    @State private var options: [String] = []  // Dynamically fetched options
    @State private var feedbackMessage: String = ""
    @State private var completedWords = 0  // Used to store the number of completed questions
    let totalWords = 10  // Total number of questions for today's task
    @State private var isMissionCompleted = false  // Prevents repeated Cost increases
    @State private var monsterImage = "Squirtle"
    @State private var monsterImages = ["Squirtle", "Charmander", "Bulbasaur"]
    @State private var currentMonsterIndex = 0
    @State private var correctTranslation: String = ""  // Added a state to store the correct translation
    @State private var defeatedMonsters: [Bool] = UserDefaults.standard.array(forKey: "defeatedMonsters") as? [Bool] ?? [false, false, false]
    
    @Environment(\.presentationMode) var presentationMode // Used to control the view's presentation mode

    var body: some View {
        ScrollView { // Add ScrollView to enable scrolling
            VStack(spacing: 20) {
                // Top navigation bar with back button
                HStack {
                    Button(action: {
                        // Return to the previous view
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundColor(.white)
                    }
                    .padding(.leading) // Align back button to the left

                    Spacer()
                }
                .padding()
                .background(Color.black.opacity(0.8)) // Set background color to black with some opacity
                    
                // Avatar and task information section
                HStack(alignment: .top) {
                    Image("Ash")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("ID: Ash")
                            .font(.headline)
                        // Dynamically display the number of completed words
                        Text("Today's Mission: \(completedWords) / \(totalWords) words")
                            .font(.subheadline)
                        HStack {
                            Text("Cost: \(playerCost)")
                                .font(.subheadline)
                                .foregroundColor(.orange)
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                // Monster and question section
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(radius: 5)
                    
                    HStack {
                        Image(monsterImage)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .offset(x: -15, y: 0)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            // Display monster HP
                            HStack {
                                Text("HP: \(monsterHP) / 100")
                                    .font(.subheadline)
                                Spacer()
                                
                                // HP progress bar
                                HStack(spacing: 0) {
                                    Capsule()
                                        .fill(Color.orange)
                                        .frame(width: CGFloat(monsterHP) / 100 * 60, height: 4)
                                    Capsule()
                                        .fill(Color.black)
                                        .frame(width: 60 - (CGFloat(monsterHP) / 100 * 60), height: 4)
                                }
                            }
                            Text("Which one is")
                                .font(.title3)
                            Text(currentQuestion)
                                .font(.largeTitle)
                                .bold()
                        }
                        .padding(.vertical)
                        .padding(.leading, 10)
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.horizontal)

                Divider().padding(.vertical)

                // Options section
                VStack(spacing: 10) {
                    ForEach(0..<2) { row in
                        HStack(spacing: 10) {
                            ForEach(0..<2) { column in
                                let index = row * 2 + column
                                if index < options.count {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.orange)
                                        .frame(width: 150, height: 70)
                                        .overlay(
                                            Text(options[index])
                                                .font(.title3)
                                                .foregroundColor(.white)
                                        )
                                        .onTapGesture {
                                            handleOptionTap(selectedOption: options[index])
                                        }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)

                // Display feedback message
                Text(feedbackMessage)
                    .font(.headline)
                    .foregroundColor(.red)
                    .padding()
                
                // Charmander section
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .shadow(radius: 5)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Charmander Lv \(charmanderLevel):")
                                .font(.headline)
                            HStack {
                                Text("Exp: \(playerEXP) / 10")
                            }
                            .font(.subheadline)
                            
                            // Exp progress bar
                            HStack(spacing: 5) {
                                Capsule()
                                    .fill(Color.orange)
                                    .frame(width: CGFloat(playerEXP) / 10 * 100, height: 5)
                                Capsule()
                                    .fill(Color.black)
                                    .frame(width: CGFloat(100 - (CGFloat(playerEXP) / 10 * 100)), height: 5)
                            }
                            
                            Text("HP: \(playerHP) / \(maxHP)")
                                .font(.subheadline)
                            
                            // HP progress bar
                            HStack(spacing: 5) {
                                Capsule()
                                    .fill(Color.orange)
                                    .frame(width: CGFloat(playerHP) / CGFloat(maxHP) * 100, height: 5)
                                Capsule()
                                    .fill(Color.black)
                                    .frame(width: CGFloat(100 - (CGFloat(playerHP) / CGFloat(maxHP) * 100)), height: 5)
                            }
                        }
                        
                        Spacer()
                        
                        Image("Charmander")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.horizontal)
                
                // Action button section
                HStack(spacing: 10) {
                    // Heal button
                    Button(action: {
                        if playerCost >= 5 {
                            playerCost -= 5
                            playerHP = min(playerHP + 5, maxHP)
                        }
                    }) {
                        VStack {
                            Image(systemName: "cross.case.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                            Text("Heal 5 Cost 5")
                                .font(.footnote)
                        }
                        .padding()
                        .frame(width: 120, height: 100)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                    
                    // Exp button
                    Button(action: {
                        if playerCost >= 5 {
                            playerCost -= 5
                            playerEXP += 5
                            if playerEXP >= 10 {
                                playerEXP = 0
                                charmanderLevel += 1
                                maxHP += 5
                                playerHP = maxHP
                            }
                        }
                    }) {
                        VStack {
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                            Text("Exp 5 Cost 5")
                                .font(.footnote)
                        }
                        .padding()
                        .frame(width: 120, height: 100)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                }
                .padding(.horizontal)
                
                // Display player's current Cost
                Text("Cost: \(playerCost)")
                    .font(.headline)
            }
            .onAppear {
                loadNewQuestion()  // Automatically call question generation function when view loads
                // Ensure that the latest defeated states are fetched from UserDefaults each time
                defeatedMonsters = UserDefaults.standard.array(forKey: "defeatedMonsters") as? [Bool] ?? [false, false, false]
            }
            .navigationBarHidden(true) // Hide the system's default back button
        } // End of ScrollView
    }

    // Load a new question
    func loadNewQuestion() {
        generateNewQuestion { question, answers, correctAnswer in
            currentQuestion = question
            options = answers
            correctTranslation = correctAnswer  // Directly assign the correct answer fetched from the database
        }
    }

    // Logic to handle option tap
    func handleOptionTap(selectedOption: String) {
        // Check if the answer is correct by directly comparing the selected option with the correct translation
        if selectedOption == correctTranslation {
            feedbackMessage = "Correct!"
            monsterHP -= 50
            playerCost += 1
            completedWords += 1
            if monsterHP <= 0 {
                defeatedMonsters[currentMonsterIndex] = true
                saveMonsterState()
                loadNewMonster()
            }
            if completedWords == totalWords && !isMissionCompleted {
                playerCost += 10  // Add 10 Cost after completing the task
                isMissionCompleted = true
            }
            loadNewQuestion()
        } else {
            feedbackMessage = "Incorrect, please try again."
            playerHP -= 5
            if playerHP < 0 {
                playerHP = 0  // Prevent HP from going negative
            }
        }
    }
    
    // Save defeated state
    func saveMonsterState() {
        UserDefaults.standard.set(defeatedMonsters, forKey: "defeatedMonsters")
    }
    
    // Load a new monster
    func loadNewMonster() {
        monsterHP = 100
        currentMonsterIndex = (currentMonsterIndex + 1) % monsterImages.count
        monsterImage = monsterImages[currentMonsterIndex]
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}




