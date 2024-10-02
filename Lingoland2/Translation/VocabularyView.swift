import SwiftUI

struct VocabularyView: View {
    @State private var userInput: String // 从主界面接收要翻译的单词
    @State private var translatedText: String = "Translating..."
    @State private var selectedLanguage: String = "English" // 默认语言为英语
    private let translationService = TranslationService()
    
    let languages = ["English", "Chinese"] // 支持的语言
    
    let languageCodes: [String: String] = [
            "English": "en",
            "Chinese": "zh"
    ]

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

            // 语言选择器
            Picker("Select Language", selection: $selectedLanguage) {
                ForEach(languages, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            // 显示翻译结果
            Text(translatedText)
                .padding()
                .font(.headline)

            // 触发翻译按钮
            Button(action: {
                translateWord() // 手动触发翻译
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
        .onAppear {
            translateWord() // 视图加载时自动调用翻译
        }
    }

    // 翻译函数
    private func translateWord() {
        // 将用户选择的语言名称转换为语言代码
        let targetLanguageCode = languageCodes[selectedLanguage] ?? "en"
        
        // 调用翻译服务
        translationService.translate(text: userInput, targetLanguage: targetLanguageCode) { translation in
            DispatchQueue.main.async {
                self.translatedText = translation ?? "Translation failed"
            }
        }
    }
}
