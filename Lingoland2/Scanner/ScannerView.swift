//
//  ScannerView.swift
//  Lingoland2
//
//  Created by Error404 on 2/9/2024.
//

import SwiftUI
import UIKit

struct ScannerView: UIViewControllerRepresentable {
    // 用来接收 OCR 结果的闭包
    var ocrResultHandler: ((String?) -> Void)?

    func makeUIViewController(context: Context) -> CameraViewController {
        let cameraViewController = CameraViewController()
        
        // 将 OCR 结果处理程序传递给 CameraViewController
        cameraViewController.ocrResult = { text in
            // 打印 OCR 结果到控制台
            print("OCR identifies result: \(text ?? "Text not recognized")")

            // 调用闭包（如果存在），传递 OCR 结果
            ocrResultHandler?(text)
        }
        return cameraViewController
    }

    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {
        // 不需要做任何更新
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
