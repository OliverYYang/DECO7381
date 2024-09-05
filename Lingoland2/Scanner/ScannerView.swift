//
//  ScannerView.swift
//  Lingoland2
//
//  Created by Error404 on 2/9/2024.
//

import SwiftUI
import UIKit

struct ScannerView: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> CameraViewController {
        return CameraViewController()
    }

    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {
        // 这里可以实现实时更新，但目前没有需要更新的内容
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
