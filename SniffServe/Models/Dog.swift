//
//  Dog.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/7/25.
//

import Foundation

struct Dog: Identifiable {
    let id = UUID()
    let name: String
    let breed: String
    var age_years: Int = 0
    var age_months: Int = 0
    let gender: String
    var chronic_conditions: [String] = []
}
