//
//  ScannerContentView.swift
//  Lingoland2
//
//  Created by Error404 on 13/9/2024.
//

import Translation // 假设 `TranslationService 2` 是文件名
import SwiftUI

import SwiftUI

struct ScannerContentView: View {
    @State private var ocrText: String = "扫描结果将在这里显示"
    @State private var translatedText: String = "翻译结果将在这里显示"
    
    // 实例化翻译服务
    private var translationService = TranslationService()

    var body: some View {
        VStack {
            Text("OCR 结果")
                .font(.headline)
            Text(ocrText) // 显示 OCR 结果
                .padding()

            Text("翻译结果")
                .font(.headline)
            Text(translatedText) // 显示翻译结果
                .padding()

            // 嵌入 ScannerView，并接收 OCR 结果
            ScannerView(ocrResultHandler: { text in
                if let ocrText = text {
                    // ScannerView 在工作，打印 OCR 结果
                    self.ocrText = ocrText
                    print("ScannerView 正在工作，OCR 结果: \(ocrText)")

                    // 首先调用语言检测 API 来确定文本的语言
                    translationService.detectLanguage(text: ocrText) { detectedLanguage in
                        DispatchQueue.main.async {
                            // 检测成功
                            if let detectedLanguage = detectedLanguage {
                                print("检测到的语言: \(detectedLanguage)")
                                
                                // 根据检测的语言决定翻译的目标语言
                                var targetLanguage: String
                                if detectedLanguage == "en" {
                                    targetLanguage = "zh-CN" // 如果是英文，翻译成中文
                                } else if detectedLanguage == "zh-CN" {
                                    targetLanguage = "en" // 如果是中文，翻译成英文
                                } else {
                                    targetLanguage = "en" // 默认翻译成英文
                                }

                                // 调用翻译 API
                                translationService.translate(text: ocrText, targetLanguage: targetLanguage) { translated in
                                    DispatchQueue.main.async {
                                        self.translatedText = translated ?? "翻译失败"
                                        print("翻译结果: \(translatedText)")
                                    }
                                }
                            } else {
                                print("无法检测到语言")
                                self.translatedText = "无法检测到语言"
                            }
                        }
                    }
                } else {
                    // ScannerView 未工作或没有检测到文本，打印提示语句
                    print("ScannerView 未检测到任何文本。")
                }
            })
            .frame(height: 400)

            Spacer()
        }
    }
}

struct ScannerContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerContentView()
    }
}
