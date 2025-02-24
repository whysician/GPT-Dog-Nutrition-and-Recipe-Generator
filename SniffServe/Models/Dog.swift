//
//  Dog.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/7/25.
//

import Foundation

struct Dog: Identifiable, Hashable {
    var id: UUID = UUID()
    let name: String
    let breed: String
    var age_years: Int = 0
    var age_months: Int = 0
    let gender: String
    var chronic_conditions: [String] = []
    var recipeIDs: [UUID] = [] // New property to hold associated recipe IDs
}

