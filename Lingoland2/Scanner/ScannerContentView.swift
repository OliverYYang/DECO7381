//
//  ScannerContentView.swift
//  Lingoland2
//
//  Created by Error404 on 13/9/2024.
//

import SwiftUI

struct ScannerContentView: View {
    @State private var ocrText: String = "扫描结果将在这里显示"

    var body: some View {
        VStack {
            Text(ocrText) // 显示 OCR 结果
                .padding()
                .font(.headline)

            // 嵌入 ScannerView，传递 OCR 结果处理程序
            ScannerView(ocrResultHandler: { text in
                ocrText = text ?? "未识别到文本"
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
