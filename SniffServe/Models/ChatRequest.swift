//
//  ChatRequest.swift
//  SniffServe
//
//  Created by Eric Tolson on 2/18/25.
//

import Foundation

// Represents a request sent to the OpenAI API.
struct ChatRequest: Codable {
    let model: String
    let messages: [ChatMessage]
}
