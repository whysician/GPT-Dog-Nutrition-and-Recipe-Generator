//
//  Recipe.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/7/25.
//

import Foundation

struct Recipe: Identifiable, Codable {
    var id: UUID = UUID()
    var title: String
    var ingredients: [String]
    var instructions: [String]
}
