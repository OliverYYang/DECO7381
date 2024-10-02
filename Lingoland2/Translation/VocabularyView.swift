import SwiftUI

struct VocabularyView: View {
    @State private var userInput: String
    @State private var translatedText: String = "Translating..."
    @State private var synonyms: [String] = [] // 用于存储同义词
    @State private var examples: [String] = [] // 用于存储例句
    private let translationService = TranslationService()
    
    // 初始化时传入用户输入的单词
    init(wordToTranslate: String) {
        _userInput = State(initialValue: wordToTranslate)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            // 显示用户输入的单词
            TextField("Enter a word...", text: $userInput)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)

            // 显示翻译结果
            Text(translatedText)
                .padding()
                .font(.headline)
            
            // 显示同义词
            if !synonyms.isEmpty {
                Text("Synonyms:")
                    .font(.headline)
                ForEach(synonyms, id: \.self) { synonym in
                    Text(synonym)
                }
            }

            // 显示例句
            if !examples.isEmpty {
                Text("Examples:")
                    .font(.headline)
                ForEach(examples, id: \.self) { example in
                    Text(example)
                }
            }
            
            // 触发翻译按钮
            Button(action: {
                detectAndTranslate() // 触发自动检测和翻译
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
            detectAndTranslate() // 视图加载时自动调用检测并翻译
        }
    }

    // 自动检测并翻译的函数
    private func detectAndTranslate() {
        // 调用语言检测服务
        translationService.detectLanguage(text: userInput) { detectedLanguage in
            guard let detectedLanguage = detectedLanguage else {
                DispatchQueue.main.async {
                    self.translatedText = "Failed to detect language"
                }
                return
            }
            
            // 如果输入是中文，则先翻译成英文，再查询词典信息
            if detectedLanguage.contains("zh") {
                translationService.translate(text: userInput, targetLanguage: "en") { translation in
                    DispatchQueue.main.async {
                        self.translatedText = translation ?? "Translation failed"
                        
                        // 翻译成英文后，使用翻译后的英文单词查询词典信息
                        if let englishWord = translation {
                            fetchSynonymsAndExamples(for: englishWord)
                        }
                    }
                }
                
            // 如果输入是英文，先查询词典，再将其翻译为中文
            } else if detectedLanguage.contains("en") {
                fetchSynonymsAndExamples(for: self.userInput)
                
                // 查询词典后，将英文单词翻译为中文
                translationService.translate(text: self.userInput, targetLanguage: "zh") { translation in
                    DispatchQueue.main.async {
                        self.translatedText = translation ?? "Translation failed"
                    }
                }
                
            } else {
                DispatchQueue.main.async {
                    self.translatedText = "Unsupported language detected: \(detectedLanguage)"
                }
            }
        }
    }

    // 使用 Free Dictionary API 获取同义词和例句
    private func fetchSynonymsAndExamples(for word: String) {
        translationService.fetchSynonymsAndExamples(for: word) { synonyms, examples in
            DispatchQueue.main.async {
                self.synonyms = synonyms ?? []
                self.examples = examples ?? []
            }
        }
    }
}
