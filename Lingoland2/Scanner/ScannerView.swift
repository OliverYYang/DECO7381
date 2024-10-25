//
//  ScannerView.swift
//  Lingoland2
//
//  Created by Error404 on 2/9/2024.
//

import SwiftUI
import UIKit

struct ScannerView: UIViewControllerRepresentable {
    var isFullScreenMode: Bool // Added to toggle mode
    var ocrResultHandler: ((String?) -> Void)?

    func makeUIViewController(context: Context) -> CameraViewController {
        let cameraViewController = CameraViewController()
        
        // Pass the mode
        cameraViewController.isFullScreenMode = isFullScreenMode
        
        // Pass the OCR result handler to CameraViewController
        cameraViewController.ocrResult = { text in
            ocrResultHandler?(text)
        }
        return cameraViewController
    }

    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {
        uiViewController.isFullScreenMode = isFullScreenMode
    }
}



