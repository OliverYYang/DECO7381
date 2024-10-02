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
    private let apiKey = "AIzaSyCgPTuHPsuQDuxDfxKc6DKXv5vxJpPZ2j4" // Replace with your actual API key
    private let baseURL = "https://translation.googleapis.com/language/translate/v2"
    
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
        
        // 将请求体转换为 JSON 数据
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            print("Failed to encode request body: \(error)")
            completion(nil)
            return
        }
        
        // 发起网络请求
        URLSession.shared.dataTask(with: request) { data, response, error in
            // 检查是否有错误
            if let error = error {
                print("Error making request: \(error)")
                completion(nil)
                return
            }
            
            // 确保有响应数据
            guard let data = data else {
                print("No data received.")
                completion(nil)
                return
            }
            
            // 解析返回的 JSON 数据
            do {
                let result = try JSONDecoder().decode(TranslationResponse.self, from: data)
                // 正确访问 Translation 结构体的 translatedText 属性
                let translatedText = result.data.translations.first?.translatedText
                completion(translatedText)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
