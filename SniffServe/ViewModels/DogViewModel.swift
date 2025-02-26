//
//  DogViewModel.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/7/25.
//

import Foundation

class DogViewModel: ObservableObject {
    @Published var dogs: [Dog] = []

    init() {
        loadSampleDogs()
    }

    func addDog(_ dog: Dog) {
        dogs.append(dog)
    }

    func deleteDog(at offsets: IndexSet) {
        dogs.remove(atOffsets: offsets)
    }

    func updateDog(_ dog: Dog, at index: Int) {
        dogs[index] = dog
    }

    private func loadSampleDogs() {
        let recipeViewModel = RecipeViewModel()
        let sampleRecipeIDs = recipeViewModel.recipes.map { $0.id }

        let sampleDogs = [
            Dog(name: "Max", breed: "Labrador Retriever", age_years: 3, age_months: 4, gender: "Male", chronic_conditions: ["Digestive issues"], recipeIDs: sampleRecipeIDs),
            Dog(name: "Daisy", breed: "French Bulldog", age_years: 14, gender: "Female", chronic_conditions: ["Blind in one eye", "Kidney issues", "Trouble walking"], recipeIDs: sampleRecipeIDs),
            Dog(name: "Charlie", breed: "Golden Retriever", age_months: 8, gender: "Male", recipeIDs: sampleRecipeIDs)
        ]

        self.dogs = sampleDogs
    }
}
