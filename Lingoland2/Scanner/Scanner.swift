//
//  Scanner.swift
//  Lingoland2
//
//  Created by Error404 on 2/9/2024.
//

import Foundation
import AVFoundation
import Vision

class Scanner: NSObject {
    
    private var textRecognitionRequest: VNRecognizeTextRequest
    
    override init() {
        // 初始化 OCR 请求
        textRecognitionRequest = VNRecognizeTextRequest(completionHandler: nil)
        textRecognitionRequest.recognitionLevel = .accurate
        textRecognitionRequest.usesLanguageCorrection = true
        textRecognitionRequest.recognitionLanguages = ["en-US", "zh-CN"] // 根据需要设置语言
        
        super.init()
    }
    
    // 处理捕获到的相机帧
    func handleCapturedFrame(_ sampleBuffer: CMSampleBuffer, completion: @escaping (String?) -> Void) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            completion(nil)
            return
        }
        
        let requestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .up, options: [:])
        
        textRecognitionRequest = VNRecognizeTextRequest { (request, error) in
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                completion(nil)
                return
            }
            
            var recognizedText = ""
            
            for observation in observations {
                guard let topCandidate = observation.topCandidates(1).first else { continue }
                recognizedText += topCandidate.string + "\n"
            }
            
            completion(recognizedText)
        }
        
        do {
            try requestHandler.perform([textRecognitionRequest])
        } catch {
            print("文本识别错误：\(error)")
            completion(nil)
        }
    }
}
