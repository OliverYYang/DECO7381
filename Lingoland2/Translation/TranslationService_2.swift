import Foundation

struct TranslationResponse: Codable {
    let data: TranslationsData
}

struct TranslationsData: Codable {
    let translations: [Translation]
}

struct Translation: Codable {
    let translatedText: String
}

struct LanguageDetectionResponse: Codable {
    let data: DetectionsData
}

struct DetectionsData: Codable {
    let detections: [[DetectedLanguage]]
}

struct DetectedLanguage: Codable {
    let language: String
    let confidence: Double
}
// 同义词响应模型
struct Definition: Codable {
    let definition: String
    let example: String?
}

struct Meaning: Codable {
    let partOfSpeech: String
    let definitions: [Definition]
}

struct FreeDictionaryResponse: Codable {
    let word: String
    let meanings: [Meaning]
}

class TranslationService {
    private let apiKey = "AIzaSyCgPTuHPsuQDuxDfxKc6DKXv5vxJpPZ2j4"
    private let baseURL = "https://translation.googleapis.com/language/translate/v2"
    private let detectURL = "https://translation.googleapis.com/language/translate/v2/detect"
    
    
    // 使用 Free Dictionary API 查询同义词和例句
    private let freeDictionaryBaseURL = "https://api.dictionaryapi.dev/api/v2/entries"

    
    // 翻译方法
    func translate(text: String, targetLanguage: String, completion: @escaping (String?) -> Void) {
        print("准备进行翻译：原始文本为 \(text)，目标语言为 \(targetLanguage)")
        
        
        guard let url = URL(string: "\(baseURL)?key=\(apiKey)") else {
            print("Invalid URL.")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody: [String: Any] = [
            "q": text,
            "target": targetLanguage,
            "format": "text"
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            print("Failed to encode request body: \(error)")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error making request: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received.")
                completion(nil)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(TranslationResponse.self, from: data)
                let translatedText = result.data.translations.first?.translatedText
                completion(translatedText)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    // 语言检测方法
    func detectLanguage(text: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "\(detectURL)?key=\(apiKey)") else {
            print("Invalid URL.")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody: [String: Any] = [
            "q": text
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            print("Failed to encode request body: \(error)")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error making request: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received.")
                completion(nil)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(LanguageDetectionResponse.self, from: data)
                let detectedLanguage = result.data.detections.first?.first?.language
                completion(detectedLanguage)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    // 使用 Free Dictionary API 获取同义词和例句
    func fetchSynonymsAndExamples(for word: String, language: String = "en", completion: @escaping ([String]?, [String]?) -> Void) {
        let urlString = "\(freeDictionaryBaseURL)/\(language)/\(word)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL.")
            completion(nil, nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error making request: \(error)")
                completion(nil, nil)
                return
            }
            
            guard let data = data else {
                print("No data received.")
                completion(nil, nil)
                return
            }
            
            do {
                let result = try JSONDecoder().decode([FreeDictionaryResponse].self, from: data)
                
                // 提取同义词和例句
                var synonyms: [String] = []
                var examples: [String] = []
                
                for meaning in result.first?.meanings ?? [] {
                    for definition in meaning.definitions {
                        if let example = definition.example {
                            examples.append(example)
                        }
                    }
                }
                
                // 将同义词从 meanings 部分解析出来，如果 API 提供了同义词
                completion(synonyms, examples)
                
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil, nil)
            }
        }.resume()
    }
}
