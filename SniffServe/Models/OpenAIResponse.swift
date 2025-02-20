//
//  OpenAIResponse.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/7/25.
//

import Foundation

struct OpenAIResponse: Codable {
    struct Choice: Codable {
        let message: ChatMessage
    }
    let choices: [Choice]
}

