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
    var scanner = Scanner() // Initialize Scanner class
    var ocrResult: ((String?) -> Void)? // Closure to pass OCR result
    var isProcessing = false // Flag to indicate if OCR recognition is in progress
    var isFullScreenMode: Bool = true // Added to control full-text or within-frame scanning

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create capture session
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .high

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

        // Set output
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
        }

        // Set video preview layer
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.frame = view.layer.bounds
        videoPreviewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(videoPreviewLayer)

        // Start capturing
        captureSession.startRunning()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        captureSession.stopRunning()
    }
}

// Extend AVCaptureVideoDataOutputSampleBufferDelegate to process frames
extension CameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard !isProcessing else { return } // Skip if processing
        
        isProcessing = true
        
        if isFullScreenMode {
            // Execute full-text scanning OCR logic
            processFullScreenOCR(sampleBuffer)
        } else {
            // Execute word mode OCR logic
            processWordModeOCR(sampleBuffer)
        }
    }

    // Full-text scan OCR
    func processFullScreenOCR(_ sampleBuffer: CMSampleBuffer) {
        // Call the scanner class to handle full-text OCR
        scanner.handleCapturedFrame(sampleBuffer) { [weak self] recognizedText in
            DispatchQueue.main.async {
                self?.ocrResult?(recognizedText ?? "Text not recognized")
                DispatchQueue.global().asyncAfter(deadline: .now() + 3.0) {
                    self?.isProcessing = false
                }
            }
        }
    }

    // Word mode scan OCR
    func processWordModeOCR(_ sampleBuffer: CMSampleBuffer) {
        // Handle logic to scan within a frame only
        // Example: Only capture the center area of the video frame
        scanner.handleCapturedFrame(sampleBuffer) { [weak self] recognizedText in
            DispatchQueue.main.async {
                self?.ocrResult?(recognizedText ?? "Text not recognized")
                DispatchQueue.global().asyncAfter(deadline: .now() + 3.0) {
                    self?.isProcessing = false
                }
            }
        }
    }
}
