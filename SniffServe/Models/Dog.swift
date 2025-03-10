//
//  Dog.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/7/25.
//

import Foundation

struct Dog: Identifiable, Hashable, Codable {
    // Represents the dog of a user
    var id = UUID()
    var name: String
    var breed: String
    var age_years: Int = 0
    var age_months: Int = 0
    var gender: String
    var chronic_conditions: [String] = []
    var recipes: [Recipe] = []
}
