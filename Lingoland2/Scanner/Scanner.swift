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
        // Initialize OCR request
        textRecognitionRequest = VNRecognizeTextRequest(completionHandler: nil)
        textRecognitionRequest.recognitionLevel = .accurate
        textRecognitionRequest.usesLanguageCorrection = true
        textRecognitionRequest.recognitionLanguages = ["en-US", "zh-CN"] // Set languages as needed
        
        super.init()
    }
    
    // Handle the captured camera frame
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
                if let topCandidate = observation.topCandidates(1).first {
                    recognizedText += topCandidate.string + "\n"
                }
            }
            
            completion(recognizedText.isEmpty ? nil : recognizedText)
        }
        
        textRecognitionRequest.recognitionLanguages = ["zh-CN", "en-US"] // Add support for Chinese and English

        do {
            try requestHandler.perform([textRecognitionRequest])
        } catch {
            print("Text recognition error: \(error)")
            completion(nil)
        }
    }
}
