import SwiftUI
import MySQLNIO

struct VocabularyView: View {
    @State private var userInput: String
    @State private var translatedText: String = "Translating..."
    @State private var synonyms: [String] = [] // Used to store synonyms
    @State private var examples: [String] = [] // Used to store examples
    private let translationService = TranslationService()
    
    // Initialize with the user's input word
    init(wordToTranslate: String) {
        _userInput = State(initialValue: wordToTranslate)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            // Display the user's input word
            TextField("Enter a word...", text: $userInput)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)

            // Display the translation result
            Text(translatedText)
                .padding()
                .font(.headline)
            
            // Display synonyms
            if !synonyms.isEmpty {
                Text("Synonyms:")
                    .font(.headline)
                ForEach(synonyms, id: \.self) { synonym in
                    Text(synonym)
                }
            }

            // Display examples
            if !examples.isEmpty {
                Text("Examples:")
                    .font(.headline)
                ForEach(examples, id: \.self) { example in
                    Text(example)
                }
            }

            // Trigger translation button
            Button(action: {
                detectAndTranslate() // Trigger automatic detection and translation
            }) {
                Text("Translate Automatically")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.horizontal)

        }
        .padding()
        .onAppear {
            detectAndTranslate() // Automatically detect and translate when the view loads
        }
    }

    
    func saveSearchHistory(searchWord: String, translatedWord: String) {
        let database = connectToDatabase()

        database.whenSuccess { connection in
            let query = "INSERT INTO review (text, translation) VALUES (?, ?)"
            
            // Convert String to MySQLData
            let parameters: [MySQLData] = [
                .init(string: searchWord),    // Convert searchWord to MySQLData
                .init(string: translatedWord) // Convert translatedWord to MySQLData
            ]
            
            connection.query(query, parameters).whenComplete { result in
                switch result {
                case .success:
                    print("Successfully inserted search history.")
                case .failure(let error):
                    print("Failed to insert search history: \(error.localizedDescription)")
                }
                connection.close().whenComplete { _ in
                    // Handle the closure of the database connection
                }
            }
        }

        database.whenFailure { error in
            print("Failed to connect to the database: \(error.localizedDescription)")
        }
    }

    // Function for automatic detection and translation
    private func detectAndTranslate() {
        // Call the language detection service
        translationService.detectLanguage(text: userInput) { detectedLanguage in
            guard let detectedLanguage = detectedLanguage else {
                DispatchQueue.main.async {
                    self.translatedText = "Failed to detect language"
                }
                return
            }
            
            // If the input is Chinese, translate it to English and then fetch dictionary information
            if detectedLanguage.contains("zh") {
                translationService.translate(text: userInput, targetLanguage: "en") { translation in
                    DispatchQueue.main.async {
                        self.translatedText = translation ?? "Translation failed"
                        
                        // After translating to English, use the translated word to fetch dictionary information
                        if let englishWord = translation {
                            // Save search history
                            saveSearchHistory(searchWord: userInput, translatedWord: englishWord)
                            fetchSynonymsAndExamples(for: englishWord)
                        }
                    }
                }
                
            // If the input is English, fetch dictionary information first, then translate to Chinese
            } else if detectedLanguage.contains("en") {
                fetchSynonymsAndExamples(for: self.userInput)
                
                // After fetching dictionary information, translate the English word to Chinese
                translationService.translate(text: self.userInput, targetLanguage: "zh") { translation in
                    DispatchQueue.main.async {
                        self.translatedText = translation ?? "Translation failed"
                        // Save search history
                        if let translatedWord = translation {
                            saveSearchHistory(searchWord: self.userInput, translatedWord: translatedWord)
                        }
                    }
                }
                
            } else {
                DispatchQueue.main.async {
                    self.translatedText = "Unsupported language detected: \(detectedLanguage)"
                }
            }
        }
    }

    // Fetch synonyms and examples using Free Dictionary API
    private func fetchSynonymsAndExamples(for word: String) {
        translationService.fetchSynonymsAndExamples(for: word) { synonyms, examples in
            DispatchQueue.main.async {
                self.synonyms = synonyms ?? []
                self.examples = examples ?? []
            }
        }
    }
}

