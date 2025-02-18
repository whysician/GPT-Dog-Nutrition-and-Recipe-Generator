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
    @Published var lastGeneratedRecipe: Recipe?
    @Published var showSaveRecipeOption = false

    func sendMessage() {
        sendChatMessage(apiKey: ProcessInfo.processInfo.environment["OPENAI_KEY"] ?? "defaultKey", message: userInput) { [weak self] reply in
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

    func generateRecipeForDog(dog: Dog) {
        let dogData = """
        Generate a detailed recipe for a dog with the following characteristics:
        Name: \(dog.name)
        Breed: \(dog.breed)
        Age: \(dog.age_years) years and \(dog.age_months) months
        Gender: \(dog.gender)
        Chronic Conditions: \(dog.chronic_conditions.joined(separator: ", "))
        Please format the recipe as follows:
        Title: [Recipe Title]
        Ingredients:
        - Ingredient 1
        - Ingredient 2
        Instructions:
        - Step 1
        - Step 2
        """
        sendChatMessage(apiKey: ProcessInfo.processInfo.environment["OPENAI_KEY"] ?? "defaultKey", message: dogData) { [weak self] reply in
            DispatchQueue.main.async {
                if let self = self, let reply = reply {
                    let aiMessage = ChatMessage(role: "ai", content: reply)
                    self.messages.append(aiMessage)

                    // Attempt to parse the reply into a Recipe
                    self.lastGeneratedRecipe = self.parseRecipeFromResponse(reply)
                    self.showSaveRecipeOption = self.lastGeneratedRecipe != nil
                }
            }
        }
    }

    private func sendChatMessage(apiKey: String, message: String, completion: @escaping (String?) -> Void) {
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

    private func parseRecipeFromResponse(_ response: String) -> Recipe? {
        let lines = response.split(separator: "\n").map(String.init)
        guard let titleIndex = lines.firstIndex(where: { $0.contains("Title:") }) else { return nil }
        let title = lines[titleIndex].replacingOccurrences(of: "Title: ", with: "").trimmingCharacters(in: .whitespacesAndNewlines)

        guard let ingredientsIndex = lines.firstIndex(where: { $0.contains("Ingredients:") }),
              let instructionsIndex = lines.firstIndex(where: { $0.contains("Instructions:") }) else { return nil }
        let ingredients = lines[(ingredientsIndex + 1)..<instructionsIndex].map { $0.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "- ", with: "") }
        let instructions = lines[(instructionsIndex + 1)...].map { $0.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "- ", with: "") }

        return Recipe(title: title, ingredients: ingredients, instructions: instructions)
    }
}
