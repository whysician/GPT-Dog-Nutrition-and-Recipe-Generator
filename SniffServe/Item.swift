//
//  Item.swift
//  GPT-Dog-Nutrition-and-Recipe-Generator
//
//  Created by Victoria Sok on 1/29/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
