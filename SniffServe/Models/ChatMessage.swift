//
//  ChatMessage.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/7/25.
//

import Foundation

// Represents a single chat message in the conversation.
struct ChatMessage: Codable, Identifiable {
    let id = UUID()
    let role: String
    let content: String
}

