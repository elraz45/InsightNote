//
//  OpenAIService.swift
//  InsightNote
//
//  Created by Elraz Hamtsani on 04/04/2025.
//

import Foundation

class OpenAIService {
    // ✅ Load API key securely from Info.plist
    private let apiKey: String = {
        guard let key = Bundle.main.infoDictionary?["OPENAI_API_KEY"] as? String else {
            fatalError("OPENAI_API_KEY not found in Info.plist")
        }
        return key
    }()

    // ✅ OpenAI summarization using Chat Completions (gpt-3.5-turbo)
    func summarize(text: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            return completion(.failure(NSError(domain: "BadURL", code: 0, userInfo: nil)))
        }

        let messages: [[String: String]] = [
            ["role": "user", "content": "Please rewrite and summarize the following text in a concise and friendly tone, ensuring that the key points are preserved and unnecessary details are omitted:\n\(text)"]
        ]

        let requestBody: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": messages,
            "temperature": 0.7
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                return completion(.failure(error))
            }
            guard let data = data else {
                return completion(.failure(NSError(domain: "NoData", code: 0, userInfo: nil)))
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let choices = json["choices"] as? [[String: Any]],
                   let first = choices.first,
                   let message = first["message"] as? [String: Any],
                   let result = message["content"] as? String {
                    completion(.success(result.trimmingCharacters(in: .whitespacesAndNewlines)))
                } else {
                    completion(.failure(NSError(domain: "BadResponse", code: 0, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
