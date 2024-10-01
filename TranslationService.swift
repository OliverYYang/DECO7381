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

class TranslationService {
    private let apiKey = "YOUR_GOOGLE_API_KEY" // Replace with your actual API key
    private let baseURL = "https://translation.googleapis.com/language/translate/v2" //API KEY 明天弄完 （整个部分运行明天完成）
    
    func translate(text: String, targetLanguage: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "\(baseURL)?key=\(apiKey)") else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody: [String: Any] = [
            "q": text,
            "target": targetLanguage
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody, options: [])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(TranslationResponse.self, from: data)
                let translatedText = result.data.translations.first?.translatedText
                completion(translatedText)
            } catch {
                completion(nil)
            }
        }.resume()
    }
}
