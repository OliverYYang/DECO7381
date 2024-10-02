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
            
            // 检查检测到的语言是否为中文或英文
            var targetLanguage = "en" // 默认翻译成英文
            
            if detectedLanguage.contains("zh") {
                targetLanguage = "en" // 如果检测到的语言是中文，目标语言设为英文
            } else if detectedLanguage.contains("en") {
                targetLanguage = "zh" // 如果检测到的语言是英文，目标语言设为中文
            } else {
                DispatchQueue.main.async {
                    self.translatedText = "Unsupported language detected: \(detectedLanguage)"
                }
                return
            }
            
            // 调用翻译服务
            translationService.translate(text: userInput, targetLanguage: targetLanguage) { translation in
                DispatchQueue.main.async {
                    self.translatedText = translation ?? "Translation failed"
                    
                    // 获取同义词和例句
                    fetchSynonymsAndExamples(for: self.userInput)
                }
            }
        }
    }

    // 获取同义词和例句的函数
    private func fetchSynonymsAndExamples(for word: String) {
        // 获取同义词
        translationService.fetchSynonyms(for: word) { synonyms in
            DispatchQueue.main.async {
                self.synonyms = synonyms ?? []
            }
        }
        
        // 获取例句
        translationService.fetchExamples(for: word) { examples in
            DispatchQueue.main.async {
                self.examples = examples ?? []
            }
        }
    }
}
