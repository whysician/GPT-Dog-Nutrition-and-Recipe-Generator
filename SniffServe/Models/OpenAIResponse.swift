//
//  OpenAIResponse.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/7/25.
//

import Foundation

// Represents a response from the OpenAI API.
struct OpenAIResponse: Codable {
    struct Choice: Codable {
        let message: ChatMessage
    }
    let choices: [Choice]
}

