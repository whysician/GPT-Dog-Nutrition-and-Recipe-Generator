//
//  RecipeListView.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/7/25.
//

import SwiftUI

struct RecipeListView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var dogViewModel: DogViewModel
    var dog: Dog

    var body: some View {
        BaseView(
            screenTitle: "Recipes for \(dog.name)",
            topLeftIcon: "chevron.backward",
            topLeftAction: {
                self.presentationMode.wrappedValue.dismiss()
            }
        ) {
            ScrollView {
                LazyVStack(spacing: 20) {
                    let dogRecipes = dog.recipes

                    if dogRecipes.isEmpty {
                        Text("No recipes found for \(dog.name)")
                            .font(.headline)
                            .padding()
                    } else {
                        ForEach(dogRecipes, id: \.id) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                RecipeCardView(recipe: recipe, deleteAction: {
                                    dogViewModel.deleteRecipe(recipe, from: dog)
                                })
                            }
                        }
                    }
                }
                .padding(.top, 10)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}



struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        let dogViewModel = DogViewModel()

        return NavigationStack {
            RecipeListView(dog: dogViewModel.dogs.first ?? Dog(
                name: "Buddy",
                breed: "Golden Retriever",
                age_years: 5,
                gender: "Male",
                chronic_conditions: ["None"],
                recipes: [
                    Recipe(title: "Doggy Dinner", ingredients: ["Chicken", "Rice"], instructions: ["Cook chicken", "Mix with rice"])
                ]
            ))
            .environmentObject(dogViewModel) // ✅ Ensure DogViewModel is included
        }
    }
}
