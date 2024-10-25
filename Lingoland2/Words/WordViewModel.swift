import Foundation
import Combine

class WordViewModel: ObservableObject {
    @Published var wordsArray: [Word] = [] // Store the fetched words
    @Published var isLoading: Bool = false // Control the loading state

    private let databaseService = DatabaseService() // Dependency on the database service

    // Fetch word data
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
                print("Word successfully added to another table")
            } else {
                print("Failed to add word")
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

