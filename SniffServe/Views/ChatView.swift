//
//  ChatView.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/7/25.
//

import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel = OpenAIViewModel()

    var body: some View {
        VStack {
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
                    ForEach(viewModel.messages) { message in
                        MessageView(message: message)
                    }
                }
                .padding(.horizontal, 15)
            }

            // Input area for sending messages
            HStack {
                TextField("Type your message here...", text: $viewModel.userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Send") {
                    viewModel.sendMessage()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
    }
}

// Custom view for displaying messages
struct MessageView: View {
    var message: ChatMessage

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

// Preview provider for SwiftUI preview
struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
