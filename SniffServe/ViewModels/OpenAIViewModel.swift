//
//  OpenAIViewModel.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/7/25.
//

import Foundation

@MainActor
class OpenAIViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var userInput: String = ""

    func sendMessage() {
        let apiKey = ProcessInfo.processInfo.environment["OPENAI_KEY"] ?? "defaultKey"
        sendChatMessage(apiKey: apiKey, message: userInput) { [weak self] reply in
            DispatchQueue.main.async {
                if let self = self, let reply = reply {
                    let userMessage = ChatMessage(role: "user", content: self.userInput)
                    let aiMessage = ChatMessage(role: "ai", content: reply)
                    self.messages.append(userMessage)
                    self.messages.append(aiMessage)
                    self.userInput = ""
                }
            }
        }
    }

    private func sendChatMessage(apiKey: String, message: String, completion: @escaping @Sendable (String?) -> Void) {
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        let userMessage = ChatMessage(role: "user", content: message)
        let requestBody = ChatRequest(model: "gpt-3.5-turbo", messages: [userMessage])

        guard let jsonData = try? JSONEncoder().encode(requestBody) else {
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error making request: \(error)")
                completion(nil)
                return
            }

            guard let data = data else {
                completion(nil)
                return
            }

            if let decodedResponse = try? JSONDecoder().decode(OpenAIResponse.self, from: data) {
                let reply = decodedResponse.choices.first?.message.content
                completion(reply)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
