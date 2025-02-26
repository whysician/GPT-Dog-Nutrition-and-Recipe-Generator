//
//  Recipe.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/7/25.
//

import Foundation

struct Recipe: Identifiable, Codable, Hashable {
    var id = UUID()
    var title: String
    var ingredients: [String]
    var instructions: [String]
}
