import Foundation

class GameStateManager {
    static let shared = GameStateManager()

    // Register global default values
    func registerDefaults() {
        UserDefaults.standard.register(defaults: [
            "monsterHP": 100,
            "playerCost": 0,
            "playerEXP": 0,
            "playerHP": 100,
            "charmanderLevel": 1,
            "completedWords": 0,
            "currentMonsterIndex": 0
        ])
    }

    // Save game data to UserDefaults
    func saveGameState(monsterHP: Int, playerCost: Int, playerEXP: Int, playerHP: Int, charmanderLevel: Int, completedWords: Int, currentMonsterIndex: Int) {
        UserDefaults.standard.set(monsterHP, forKey: "monsterHP")
        UserDefaults.standard.set(playerCost, forKey: "playerCost")
        UserDefaults.standard.set(playerEXP, forKey: "playerEXP")
        UserDefaults.standard.set(playerHP, forKey: "playerHP")
        UserDefaults.standard.set(charmanderLevel, forKey: "charmanderLevel")
        UserDefaults.standard.set(completedWords, forKey: "completedWords")
        UserDefaults.standard.set(currentMonsterIndex, forKey: "currentMonsterIndex")
    }

    // Load game data from UserDefaults
    func loadGameState() -> (monsterHP: Int, playerCost: Int, playerEXP: Int, playerHP: Int, charmanderLevel: Int, completedWords: Int, currentMonsterIndex: Int) {
        return (
            UserDefaults.standard.integer(forKey: "monsterHP"),
            UserDefaults.standard.integer(forKey: "playerCost"),
            UserDefaults.standard.integer(forKey: "playerEXP"),
            UserDefaults.standard.integer(forKey: "playerHP"),
            UserDefaults.standard.integer(forKey: "charmanderLevel"),
            UserDefaults.standard.integer(forKey: "completedWords"),
            UserDefaults.standard.integer(forKey: "currentMonsterIndex")
        )
    }
}

