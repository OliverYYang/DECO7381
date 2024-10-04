//
//  CameraViewController.swift
//  Lingoland2
//
//  Created by Error404 on 2/9/2024.
//


import UIKit
import AVFoundation
import Vision

class CameraViewController: UIViewController {

    var captureSession: AVCaptureSession!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var scanner = Scanner() // 初始化 Scanner 类
    var ocrResult: ((String?) -> Void)? // 用于传递 OCR 结果的闭包
    var isProcessing = false // 标记是否正在进行 OCR 识别

    override func viewDidLoad() {
        super.viewDidLoad()

        // 创建捕获会话
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .high

        // 设置输入设备为相机
        guard let videoCaptureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else { return }
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            return
        }

        // 设置输出
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
        }

        // 设置视频预览层
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.frame = view.layer.bounds
        videoPreviewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(videoPreviewLayer)

        // 开始捕获
        captureSession.startRunning()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        captureSession.stopRunning()
    }
}

// 扩展 AVCaptureVideoDataOutputSampleBufferDelegate 以处理帧
extension CameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        // 如果当前正在处理 OCR，则跳过这一帧
        guard !isProcessing else { return }
        
        isProcessing = true // 标记为正在处理
        
        // 使用 Scanner 类处理帧并进行 OCR 识别
        scanner.handleCapturedFrame(sampleBuffer) { [weak self] recognizedText in
            DispatchQueue.main.async {
                // 将 OCR 结果传递给 ScannerView
                self?.ocrResult?(recognizedText ?? "Text not recognized")
                
                // 打印 OCR 识别结果
//                print("OCR identifies result: \(recognizedText ?? "Text not recognized")")
                
                // 延迟 3 秒后再允许处理下一帧
                DispatchQueue.global().asyncAfter(deadline: .now() + 3.0) {
                    self?.isProcessing = false
                }
            }
        }
    }
}
