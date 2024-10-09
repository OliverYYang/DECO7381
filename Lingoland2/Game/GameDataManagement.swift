//
//  GameDataManagement.swift
//  Lingoland2
//
//  Created by 杨小洲 on 2024/10/9.
//

import Foundation

class GameStateManager {
    static let shared = GameStateManager()

    // 保存游戏数据到UserDefaults
    func saveGameState(monsterHP: Int, playerCost: Int, playerEXP: Int, playerHP: Int, charmanderLevel: Int, completedWords: Int, currentMonsterIndex: Int) {
        UserDefaults.standard.set(monsterHP, forKey: "monsterHP")
        UserDefaults.standard.set(playerCost, forKey: "playerCost")
        UserDefaults.standard.set(playerEXP, forKey: "playerEXP")
        UserDefaults.standard.set(playerHP, forKey: "playerHP")
        UserDefaults.standard.set(charmanderLevel, forKey: "charmanderLevel")
        UserDefaults.standard.set(completedWords, forKey: "completedWords")
        UserDefaults.standard.set(currentMonsterIndex, forKey: "currentMonsterIndex")
    }

    // 从UserDefaults加载游戏数据
    func loadGameState() -> (monsterHP: Int, playerCost: Int, playerEXP: Int, playerHP: Int, charmanderLevel: Int, completedWords: Int, currentMonsterIndex: Int) {
        let monsterHP = UserDefaults.standard.integer(forKey: "monsterHP")
        let playerCost = UserDefaults.standard.integer(forKey: "playerCost")
        let playerEXP = UserDefaults.standard.integer(forKey: "playerEXP")
        let playerHP = UserDefaults.standard.integer(forKey: "playerHP")
        let charmanderLevel = UserDefaults.standard.integer(forKey: "charmanderLevel")
        let completedWords = UserDefaults.standard.integer(forKey: "completedWords")
        let currentMonsterIndex = UserDefaults.standard.integer(forKey: "currentMonsterIndex")

        return (monsterHP == 0 ? 100 : monsterHP, playerCost, playerEXP, playerHP == 0 ? 100 : playerHP, charmanderLevel == 0 ? 1 : charmanderLevel, completedWords, currentMonsterIndex)
    }
}
