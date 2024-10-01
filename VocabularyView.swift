import SwiftUI

struct VocabularyView: View {
    @State private var userInput: String = "" // Stores the word input by the user
    @State private var translatedText: String = "Enter a word to translate"
    @State private var selectedLanguage: String = "en" // Default language is English
    private let translationService = TranslationService()
    
    let languages = ["en", "zh", "es"] // You can add more languages
    
    var body: some View {
        VStack(spacing: 20) {
            // Input field for the user to type any word
            TextField("Enter a word...", text: $userInput)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)

            // Language selection picker
            Picker("Select Language", selection: $selectedLanguage) {
                ForEach(languages, id: \.self) {
                    Text($0) // Display language codes
                }
            }
            .pickerStyle(SegmentedPickerStyle()) // You can use different styles
            .padding()

            // Display the translated text
            Text(translatedText)
                .padding()
                .font(.headline)

            // Button to trigger the translation
            Button(action: {
                if !userInput.isEmpty {
                    translateWord() // Translate the input word with selected language
                }
            }) {
                Text("Translate to \(selectedLanguage)")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
        }
        .padding()
    }

    private func translateWord() {
        translationService.translate(text: userInput, targetLanguage: selectedLanguage) { translation in
            DispatchQueue.main.async {
                self.translatedText = translation ?? "Translation failed"
            }
        }
    }
}
