//
//  ChatMessage.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/7/25.
//

import Foundation

struct ChatMessage: Codable, Identifiable {
    let id = UUID()
    let role: String
    let content: String
}

