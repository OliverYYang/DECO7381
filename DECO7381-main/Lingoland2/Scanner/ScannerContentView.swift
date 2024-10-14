//
//  ScannerContentView.swift
//  Lingoland2
//
//  Created by Error404 on 13/9/2024.
//

import Translation // 假设 `TranslationService 2` 是文件名
import MySQLNIO
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
                                
                                // 如果检测到是英文，将其翻译为中文后插入 `review` 表
                                if detectedLanguage == "en" {
                                    print("检测到英文单词，准备加入到词库: \(ocrText)")
                                    
                                    // 翻译成中文
                                    translationService.translate(text: ocrText, targetLanguage: "zh-CN") { translated in
                                        DispatchQueue.main.async {
                                            self.translatedText = translated ?? "翻译失败"
                                            print("翻译结果: \(translatedText)")
                                            
                                            // 调用保存方法，将英文和翻译后的中文插入 `review` 表
                                            saveOCRResult(ocrText: ocrText, translatedText: translatedText)
                                        }
                                    }

                                // 如果检测到是中文，则翻译成英文
                                } else if detectedLanguage == "zh-CN" {
                                    // 翻译成英文
                                    translationService.translate(text: ocrText, targetLanguage: "en") { translated in
                                        DispatchQueue.main.async {
                                            self.translatedText = translated ?? "翻译失败"
                                            print("翻译结果: \(translatedText)")
                                            
                                            // 调用保存方法，将中文和翻译后的英文插入 `review` 表
                                            saveOCRResult(ocrText: ocrText, translatedText: translatedText)
                                        }
                                    }
                                } else {
                                    print("不支持的语言: \(detectedLanguage)")
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

    // 保存 OCR 扫描到的文本和翻译结果到 `review` 表中
    func saveOCRResult(ocrText: String, translatedText: String) {
        // 过滤掉无法识别的内容
        guard ocrText != "Text not recognized", !ocrText.isEmpty else {
            print("无效的 OCR 文本，不进行数据库插入")
            return
        }

        let database = connectToDatabase()

        database.whenSuccess { connection in
            let query = "INSERT INTO review (text, translation) VALUES (?, ?)"
            
            // 将字符串转换为 MySQLData
            let parameters: [MySQLData] = [
                .init(string: ocrText),    // OCR 扫描到的文本
                .init(string: translatedText) // 翻译结果
            ]
            
            connection.query(query, parameters).whenComplete { result in
                switch result {
                case .success:
                    print("成功将以下内容插入 review 表：")
                    print("OCR 文本: \(ocrText), 翻译文本: \(translatedText)")
                case .failure(let error):
                    print("插入 OCR 文本失败: \(error.localizedDescription)")
                }
                connection.close().whenComplete { _ in
                    // 数据库连接关闭
                }
            }
        }

        database.whenFailure { error in
            print("数据库连接失败: \(error.localizedDescription)")
        }
    }
}


struct ScannerContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerContentView()
    }
}
