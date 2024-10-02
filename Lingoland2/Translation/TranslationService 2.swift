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
struct SynonymEntry: Codable {
    let synonyms: [Synonym]
}

struct Synonym: Codable {
    let text: String
}

// 例句响应模型
struct ExampleResponse: Codable {
    let examples: [Example]
}

struct Example: Codable {
    let text: String
}


class TranslationService {
    private let apiKey = "AIzaSyCgPTuHPsuQDuxDfxKc6DKXv5vxJpPZ2j4"
    private let baseURL = "https://translation.googleapis.com/language/translate/v2"
    private let detectURL = "https://translation.googleapis.com/language/translate/v2/detect"
    
    private let oxfordAppID = "65660b75"
    private let oxfordAppKey = "27a348ba651a5a58a230234345fd1798" 
    private let oxfordBaseURL = "https://od-api-sandbox.oxforddictionaries.com/api/v2"
    
    // 翻译方法
    func translate(text: String, targetLanguage: String, completion: @escaping (String?) -> Void) {
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
    
    // 获取同义词
    func fetchSynonyms(for word: String, language: String = "en-gb", completion: @escaping ([String]?) -> Void) {
        let urlString = "\(oxfordBaseURL)/entries/\(language)/\(word)/synonyms"
        guard let url = URL(string: urlString) else {
            print("Invalid URL.")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(oxfordAppID, forHTTPHeaderField: "app_id")
        request.setValue(oxfordAppKey, forHTTPHeaderField: "app_key")
        
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
                // 首先解析为字典以检查是否存在错误
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let errorMessage = jsonResponse["error"] as? String {
                    print("Error from API: \(errorMessage)")
                    completion(nil)
                    return
                }
                
                // 如果没有错误，解析同义词数据
                let result = try JSONDecoder().decode([SynonymEntry].self, from: data)
                let synonyms = result.flatMap { $0.synonyms.map { $0.text } }
                completion(synonyms)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    // 获取例句
    func fetchExamples(for word: String, language: String = "en-gb", completion: @escaping ([String]?) -> Void) {
        let urlString = "\(oxfordBaseURL)/entries/\(language)/\(word)/sentences"
        guard let url = URL(string: urlString) else {
            print("Invalid URL.")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(oxfordAppID, forHTTPHeaderField: "app_id")
        request.setValue(oxfordAppKey, forHTTPHeaderField: "app_key")
        
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
                // 首先解析为字典以检查是否存在错误
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let errorMessage = jsonResponse["error"] as? String {
                    print("Error from API: \(errorMessage)")
                    completion(nil)
                    return
                }
                
                // 如果没有错误，解析例句数据
                let result = try JSONDecoder().decode(ExampleResponse.self, from: data)
                let examples = result.examples.map { $0.text }
                completion(examples)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
