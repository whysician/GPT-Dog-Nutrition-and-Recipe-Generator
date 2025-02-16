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

    private func loadSampleRecipes() {
        let sampleRecipes = [
            Recipe(title: "Puppy Chow", ingredients: ["2 cups rice", "1 cup chicken breast", "1 tbsp olive oil", "3 cups water"], instructions: ["Cut chicken into small pieces", "Cook rice and chicken in water until tender", "Drain and mix with olive oil"]),
            Recipe(title: "Healthy Dog Biscuits", ingredients: ["2 cups whole wheat flour", "1/2 cup oats", "1 tbsp dried parsley", "1/3 cup peanut butter", "1 cup hot water"], instructions: ["Preheat oven to 350°F", "Mix all dry ingredients", "Add peanut butter and hot water", "Roll out dough and cut into shapes", "Bake for 30 minutes"]),
            Recipe(title: "Doggy Meatloaf", ingredients: ["1 pound ground turkey", "1/2 cup carrots, chopped", "1/2 cup peas", "1 egg", "1/2 cup rolled oats"], instructions: ["Preheat oven to 375°F", "Mix all ingredients thoroughly", "Press mixture into a loaf pan", "Bake for 45 minutes"])
        ]
        self.recipes = sampleRecipes
    }
}
