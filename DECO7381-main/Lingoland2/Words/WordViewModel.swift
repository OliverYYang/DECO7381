//
//  WordViewModel.swift
//  Lingoland2
//
//  Created by 杨小洲 on 2024/10/9.
//

import Foundation
import Combine

class WordViewModel: ObservableObject {
    @Published var wordsArray: [Word] = [] // 存储获取到的单词
    @Published var isLoading: Bool = false // 控制加载状态

    private let databaseService = DatabaseService() // 依赖数据库服务

    // 获取单词数据
    func fetchWords() {
        self.isLoading = true
        databaseService.fetchWords { [weak self] words in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.wordsArray = words
                self.isLoading = false
            }
        }
    }
    
    func addToAnotherTable(word: Word) {
        databaseService.addWordToAnotherTable(word: word) { success in
            if success {
                print("单词成功添加到另一个表中")
            } else {
                print("添加单词失败")
            }
        }
    }
    
    func sortWords(order: Int) {
        if order == 1 {
            wordsArray.sort { $0.word.lowercased() < $1.word.lowercased() }
        } else {
            wordsArray.sort { $0.word.lowercased() > $1.word.lowercased() }
        }
    }

}
