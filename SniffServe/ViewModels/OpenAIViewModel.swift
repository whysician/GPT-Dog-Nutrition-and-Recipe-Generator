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
        guard !userInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }

        let userMessage = ChatMessage(role: "user", content: userInput)
        messages.append(userMessage)

        sendToOpenAI(messages) { [weak self] response in
            DispatchQueue.main.async {
                if let response = response {
                    self?.messages.append(ChatMessage(role: "assistant", content: response))
                }
                self?.userInput = ""
            }
        }
    }

    func generateRecipeForDog(dog: Dog) {
        let dogData = """
        Generate a detailed recipe with a unique title for a dog with these details:
        Name: \(dog.name)
        Breed: \(dog.breed)
        Age: \(dog.age_years) years, \(dog.age_months) months
        Gender: \(dog.gender)
        Chronic Conditions: \(dog.chronic_conditions.joined(separator: ", "))

        Format the response as:
        Title: [Recipe Title]
        Ingredients:
        - Ingredient 1
        - Ingredient 2
        Instructions:
        - Step 1
        - Step 2
        """

        sendToOpenAI(messages + [ChatMessage(role: "user", content: dogData)]) { [weak self] response in
            DispatchQueue.main.async {
                if let response = response {
                    self?.messages.append(ChatMessage(role: "assistant", content: response))
                    self?.lastGeneratedRecipe = self?.parseRecipeFromResponse(response)
                    self?.showSaveRecipeOption = self?.lastGeneratedRecipe != nil
                }
            }
        }
    }

    func sendDogStats(dog: Dog) {
        let dogStatsMessage = """
        The user has a dog with these details:
        Name: \(dog.name)
        Breed: \(dog.breed)
        Age: \(dog.age_years) years, \(dog.age_months) months
        Gender: \(dog.gender)
        Chronic Conditions: \(dog.chronic_conditions.joined(separator: ", "))

        Keep this information in mind for the conversation.
        """

        let userMessage = ChatMessage(role: "user", content: dogStatsMessage)
        messages.append(userMessage)

        sendToOpenAI(messages) { [weak self] response in
            DispatchQueue.main.async {
                if let response = response {
                    self?.messages.append(ChatMessage(role: "assistant", content: response))
                }
            }
        }
    }

    private func sendToOpenAI(_ chatHistory: [ChatMessage], completion: @escaping (String?) -> Void) {
        let requestBody = ChatRequest(model: "gpt-3.5-turbo", messages: chatHistory)

        guard let jsonData = try? JSONEncoder().encode(requestBody) else {
            print("Failed to encode request body")
            completion(nil)
            return
        }

        var request = URLRequest(url: URL(string: "https://api.openai.com/v1/chat/completions")!)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(ProcessInfo.processInfo.environment["OPENAI_KEY"] ?? "defaultKey")", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Request error: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("No response data received")
                completion(nil)
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(OpenAIResponse.self, from: data)
                completion(decodedResponse.choices.first?.message.content)
            } catch {
                print("Failed to decode response: \(error)")
                print("Response Data: \(String(data: data, encoding: .utf8) ?? "N/A")")
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
