//
//  RecipeViewModel.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/7/25.
//

import Foundation
import Combine

class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []

    init() {
        loadSampleRecipes()
    }

    func addRecipe(_ recipe: Recipe) {
        recipes.append(recipe)
    }

    func deleteRecipes(at offsets: IndexSet) {
        recipes.remove(atOffsets: offsets)
    }

    func recipes(forDog dog: Dog) -> [Recipe] {
        return recipes.filter { dog.recipeIDs.contains($0.id) }
    }

    func loadSampleRecipes() {
            // Simulate adding two sample recipes
            recipes.append(Recipe(id: UUID(), title: "Doggy Dinner", ingredients: ["Chicken", "Rice"], instructions: ["Cook chicken", "Mix with rice"]))
            recipes.append(Recipe(id: UUID(), title: "Puppy Breakfast", ingredients: ["Beef", "Potato"], instructions: ["Boil beef", "Mash potato"]))
        }
}
