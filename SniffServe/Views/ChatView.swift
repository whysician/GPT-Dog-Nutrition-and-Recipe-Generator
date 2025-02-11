//
//  PetHomeView.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/7/25.
//

import SwiftUI

// Define the data structures for handling the API interactions
struct Message: Codable, Identifiable {
    let id = UUID()
    let role: String
    let content: String
}

struct ChatRequest: Codable {
    let model: String
    let messages: [Message]
}

struct ChatResponse: Codable {
    struct Choice: Codable {
        let message: Message
    }
    let choices: [Choice]
}

// ChatView with integrated chat functionality
struct ChatView: View {
    @State private var userInput: String = ""
    @State private var messages: [Message] = []

    var body: some View {
        VStack {
            // Chat header, can replace or modify according to the layout needs
            HStack {
                Button(action: {}) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.black)
                        .font(.title)
                }
                .padding(.leading, 10)

                Spacer()

                Text("Chat with AI")
                    .font(.title)
                    .bold()

                Spacer()
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)

            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(messages) { message in
                        MessageView(message: message)
                    }
                }
                .padding(.horizontal, 15)
            }

            // Input area for sending messages
            HStack {
                TextField("Type your message here...", text: $userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Send") {
                    sendMessage()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
    }

    func sendMessage() {
        let apiKey = ProcessInfo.processInfo.environment["OPENAI_KEY"] ?? "defaultKey"  // Use the actual API key here
        sendChatMessage(apiKey: apiKey, message: userInput) { reply in
            DispatchQueue.main.async {
                if let reply = reply {
                    let userMessage = Message(role: "user", content: userInput)
                    let aiMessage = Message(role: "ai", content: reply)
                    messages.append(userMessage)
                    messages.append(aiMessage)
                    userInput = ""
                }
            }
        }
    }
}

// Custom view for displaying messages
struct MessageView: View {
    var message: Message

    var body: some View {
        HStack {
            if message.role == "user" {
                Spacer()
                Text(message.content)
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(10)
                    .foregroundColor(Color.black)
            } else {
                Text(message.content)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .foregroundColor(Color.black)
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}

// Function to handle sending messages to OpenAI API
func sendChatMessage(apiKey: String, message: String, completion: @escaping @Sendable (String?) -> Void) {
    let url = URL(string: "https://api.openai.com/v1/chat/completions")!
    let userMessage = Message(role: "user", content: message)
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

        if let decodedResponse = try? JSONDecoder().decode(ChatResponse.self, from: data) {
            let reply = decodedResponse.choices.first?.message.content
            completion(reply)
        } else {
            completion(nil)
        }
    }
    task.resume()
}

// Preview provider for SwiftUI preview
struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
