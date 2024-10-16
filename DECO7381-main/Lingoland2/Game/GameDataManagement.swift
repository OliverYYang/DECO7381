//
//  GameDataManagement.swift
//  Lingoland2
//
//  Created by 杨小洲 on 2024/10/9.
//

import Foundation

class GameStateManager {
    static let shared = GameStateManager()

    // 注册全局默认值
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
