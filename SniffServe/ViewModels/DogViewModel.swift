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

    func updateDog(_ dog: Dog) {
        if let index = dogs.firstIndex(where: { $0.id == dog.id }) {
            dogs[index] = dog
        }
    }

    func addRecipe(_ recipe: Recipe, to dog: Dog) {
        if let index = dogs.firstIndex(where: { $0.id == dog.id }) {
            dogs[index].recipes.append(recipe)
        }
    }

    func deleteRecipe(_ recipe: Recipe, from dog: Dog) {
        if let index = dogs.firstIndex(where: { $0.id == dog.id }) {
            dogs[index].recipes.removeAll { $0.id == recipe.id }
        }
    }

    private func loadSampleDogs() {
        let sampleRecipes = [
            Recipe(title: "Doggy Dinner", ingredients: ["Chicken", "Rice"], instructions: ["Cook chicken", "Mix with rice"]),
            Recipe(title: "Puppy Breakfast", ingredients: ["Beef", "Potato"], instructions: ["Boil beef", "Mash potato"])
        ]

        let sampleDogs = [
            Dog(name: "Max", breed: "Labrador Retriever", age_years: 3, gender: "Male", chronic_conditions: ["Digestive issues"], recipes: [sampleRecipes[0]]),
            Dog(name: "Daisy", breed: "French Bulldog", age_years: 14, gender: "Female", chronic_conditions: ["Blind in one eye", "Kidney issues", "Trouble walking"], recipes: []),
            Dog(name: "Charlie", breed: "Golden Retriever", age_months: 8, gender: "Male", chronic_conditions: [], recipes: [sampleRecipes[1]])
        ]

        self.dogs = sampleDogs
    }
}
