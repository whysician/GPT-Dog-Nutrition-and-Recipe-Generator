//
//  DogViewModel.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/7/25.
//

import Foundation

class DogViewModel: ObservableObject {
    private var userDefaults = UserDefaults.standard  // Used for data persistence of the dog list
    @Published var dogs: [Dog] = []   // Field that represents the list of dogs for a user


    init() {
        // Loads the saved list of dogs whenever the app is used
        if let savedDogData = userDefaults.object(forKey: "dogs") as? Data {
            do {
                dogs = try JSONDecoder().decode([Dog].self, from: savedDogData)
            } catch {
                print("Failed to load saved dogs: \(error)")
            }
        }
    }

    func addDog(name: String, breed: String, ageYears: Int, ageMonths: Int, gender: String, conditions: [String]) {
        // Adds a new dog to the dog list with the the provided information
        let newDog = Dog(
            name: name,
            breed: breed,
            age_years: ageYears,
            age_months: ageMonths,
            gender: gender,
            chronic_conditions: conditions
        )
        DispatchQueue.main.async {
            self.dogs.append(newDog)
            self.saveDogList()
            print("New pet added: \(newDog)")
        }

    }

    func deleteDog(at offsets: IndexSet) {
        // Deletes a dog from the dog list with the provided index
        dogs.remove(atOffsets: offsets)
        saveDogList()
    }

    func updateDog(_ dog: Dog) {
        // Edits a dog in the dog list with the same id as the provided dog
        if let index = dogs.firstIndex(where: { $0.id == dog.id }) {
            dogs[index] = dog
        }
        saveDogList()
    }

    func addRecipe(_ recipe: Recipe, to dog: Dog) {
        // Adds a recipe to the saved recipe list of the provided dog
        if let index = dogs.firstIndex(where: { $0.id == dog.id }) {
            dogs[index].recipes.append(recipe)
        }
        saveDogList()
    }

    func deleteRecipe(_ recipe: Recipe, from dog: Dog) {
        // Deletes a recipe of the dog with the same id as the provided dog
        // The recipe deleted has the same id and the provided recipe
        if let index = dogs.firstIndex(where: { $0.id == dog.id }) {
            dogs[index].recipes.removeAll { $0.id == recipe.id }
        }
        saveDogList()
    }

    private func loadSampleDogs() {
        // Loads sample dogs used for testing
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
    
    func saveDogList() {
        // Allows data persistence by saving the list of dogs using UserDefaults
        do {
            let encodedDogs = try JSONEncoder().encode(dogs)
            userDefaults.set(encodedDogs, forKey: "dogs")
        } catch {
            print("Unable to save dogs: \(error)")
        }
    }
}
