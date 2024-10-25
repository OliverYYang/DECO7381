//
//  ScannerContentView.swift
//  Lingoland2
//
//  Created by Error404 on 13/9/2024.
//

import SwiftUI
import MySQLNIO

struct ScannerContentView: View {
    @State private var ocrText: String = ""
    @State private var translatedText: String = ""
    @State private var isFullScreenMode: Bool = true // Toggle mode
    @State private var countdown: Int = 3 // Countdown number
    @State private var isCountingDown = true // Whether counting down
    @State private var timer: Timer? // Timer for countdown
    @State private var lastOCRText: String? = nil // Last scanned text
    @State private var resultShown = false // Whether to show OCR and translation results

    // Instantiate translation service
    private var translationService = TranslationService()

    var body: some View {
        ZStack {
            // Camera view
            ScannerView(isFullScreenMode: isFullScreenMode, ocrResultHandler: { text in
                // Only process OCR text after countdown ends
                if !isCountingDown {
                    if lastOCRText != text {
                        lastOCRText = text
                        performOCR() // Process OCR recognition after countdown ends
                    }
                }
            })
            .edgesIgnoringSafeArea(.all) // Let camera cover the entire view
            
            VStack {
                // Two buttons at the top displayed side by side
                HStack {
                    Button(action: {
                        isFullScreenMode = true // Switch to full-text scan
                    }) {
                        Text("Full-text Scan")
                            .foregroundColor(Color.white)
                            .padding()
                            .background(isFullScreenMode ? Color.orange : Color.black.opacity(0.8))
                            .cornerRadius(8)
                    }

                    Button(action: {
                        isFullScreenMode = false // Switch to word selection mode
                    }) {
                        Text("Word Selection Mode")
                            .foregroundColor(Color.white)
                            .padding()
                            .background(!isFullScreenMode ? Color.orange : Color.black.opacity(0.8))
                            .cornerRadius(8)
                    }
                }
                .background(Color.black.opacity(0)) // Button background fixed at the top of the camera view
                .frame(maxWidth: .infinity, maxHeight: 50) // Fixed height
                .padding(.top, 10) // Top padding

                // Add the warning text
                Text("Please note: Please do not use this function in dangerous environments!")
                    .font(.footnote)
                    .foregroundColor(.white.opacity(1)) // Semi-transparent text
                    .padding() // Create space between text and background
                    .background(Color.black.opacity(0.8)) // Background color
                    .cornerRadius(10) // Rounded corners for the background
                    .padding(.top, 5) // Padding from the top


                
                Spacer()

                // Cropping box in word selection mode
                if !isFullScreenMode {
                    GeometryReader { geometry in
                        let width = 200.0
                        let height = 100.0
                        Rectangle()
                            .strokeBorder(Color.orange, lineWidth: 2) // Set to orange border
                            .background(Color.black.opacity(0.2))  // Semi-transparent background
                            .frame(width: width, height: height)   // Set box size
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2) // Centered
                    }
                }

                // Directly display translation content on top of the camera
                if resultShown {
                    VStack {
                        Text(ocrText)
                            .font(.headline)
                            .padding(.horizontal)
                        Text(translatedText)
                            .font(.headline)
                            .padding(.horizontal)
                    }
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                }
            }

            // Countdown animation, placed in the center of the camera view
            if isCountingDown {
                Text("\(countdown)")
                    .font(.system(size: 64, weight: .bold))
                    .foregroundColor(Color.white)
                    .transition(.opacity)
                    .onAppear {
                        startCountdown() // Start countdown
                    }
            }
        }
    }

    // Start countdown
    private func startCountdown() {
        countdown = 5
        isCountingDown = true
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if countdown > 1 {
                countdown -= 1
            } else {
                timer?.invalidate()
                isCountingDown = false
                performOCR() // Perform OCR and translation logic after countdown ends
            }
        }
    }

    // Perform OCR and translation logic
    private func performOCR() {
        if let text = lastOCRText {
            self.ocrText = text
            resultShown = true

            // Call translation handling logic
            handleTranslation(ocrText: text)

            // Hide the result and restart countdown after 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                resultShown = false
                startCountdown() // Restart countdown
            }
        }
    }

    // Translation handling logic - differentiate between English and Chinese parts
    private func handleTranslation(ocrText: String) {
        let englishText = ocrText.extractEnglishPart() // Extract English part
        let chineseText = ocrText.extractChinesePart() // Extract Chinese part
        
        var finalTranslation = ""

        // Translate English part
        if !englishText.isEmpty {
            translationService.translate(text: englishText, targetLanguage: "zh-CN") { translated in
                DispatchQueue.main.async {
                    finalTranslation += translated ?? ""
                    self.translatedText = finalTranslation
                    
                    // Save English and its translation to the database only in word selection mode
                    if !self.isFullScreenMode {
                        self.saveOCRResult(ocrText: englishText, translatedText: self.translatedText)
                    }
                }
            }
        }

        // Translate Chinese part and display
        if !chineseText.isEmpty {
            translationService.translate(text: chineseText, targetLanguage: "en") { translated in
                DispatchQueue.main.async {
                    finalTranslation += "\n" + (translated ?? "")
                    self.translatedText = finalTranslation
                }
            }
        }
    }

    // Save OCR-scanned English text and translation results to the `review` table
    func saveOCRResult(ocrText: String, translatedText: String) {
        // Filter out unrecognized content
        guard ocrText != "Text not recognized", !ocrText.isEmpty else {
            print("Invalid OCR text, no database insertion")
            return
        }

        let database = connectToDatabase()

        database.whenSuccess { connection in
            let query = "INSERT INTO review (text, translation) VALUES (?, ?)"
            
            // Convert strings to MySQLData
            let parameters: [MySQLData] = [
                .init(string: ocrText),    // OCR-scanned text
                .init(string: translatedText) // Translation result
            ]
            
            connection.query(query, parameters).whenComplete { result in
                switch result {
                case .success:
                    print("Successfully inserted the following into the review table:")
                    print("OCR text: \(ocrText), Translation text: \(translatedText)")
                case .failure(let error):
                    print("Failed to insert OCR text: \(error.localizedDescription)")
                }
                connection.close().whenComplete { _ in
                    // Database connection closed
                }
            }
        }

        database.whenFailure { error in
            print("Database connection failed: \(error.localizedDescription)")
        }
    }
}

// Hypothetical helper functions for extracting English and Chinese parts
extension String {
    // Extract English part
    func extractEnglishPart() -> String {
        let pattern = "[A-Za-z\\s]+" // Match letters and spaces
        let regex = try? NSRegularExpression(pattern: pattern)
        let results = regex?.matches(in: self, range: NSRange(self.startIndex..., in: self))
        let englishPart = results?.compactMap {
            Range($0.range, in: self).map { String(self[$0]) }
        }.joined(separator: " ") ?? ""
        return englishPart.trimmingCharacters(in: .whitespaces)
    }

    // Extract Chinese part
    func extractChinesePart() -> String {
        let pattern = "[\\u4e00-\\u9fff]+" // Match Chinese characters
        let regex = try? NSRegularExpression(pattern: pattern)
        let results = regex?.matches(in: self, range: NSRange(self.startIndex..., in: self))
        let chinesePart = results?.compactMap {
            Range($0.range, in: self).map { String(self[$0]) }
        }.joined(separator: " ") ?? ""
        return chinesePart.trimmingCharacters(in: .whitespaces)
    }
}

struct ScannerContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerContentView()
    }
}

