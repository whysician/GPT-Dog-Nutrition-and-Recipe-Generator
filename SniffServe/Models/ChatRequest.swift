//
//  ChatRequest.swift
//  SniffServe
//
//  Created by Eric Tolson on 2/18/25.
//

import Foundation

struct ChatRequest: Codable {
    let model: String
    let messages: [ChatMessage]
}
