//
//  RecipeListView.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/7/25.
//

import SwiftUI

struct RecipeListView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: RecipeViewModel
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
                    let dogRecipes = viewModel.recipes.filter { dog.recipeIDs.contains($0.id) }

                    if dogRecipes.isEmpty {
                        Text("No recipes found for \(dog.name)")
                            .font(.headline)
                            .padding()
                    } else {
                        ForEach(dogRecipes, id: \.id) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                RecipeCardView(recipe: recipe, deleteAction: {
                                    if let index = viewModel.recipes.firstIndex(where: { $0.id == recipe.id }) {
                                        viewModel.deleteRecipes(at: IndexSet(integer: index))
                                    }
                                })
                            }
                        }
                    }
                }
                .padding(.top, 10)
            }
            .onAppear {
                // ✅ Ensure dog has the correct recipe IDs on view load
                var updatedDog = dog
                updatedDog.recipeIDs = viewModel.recipes.map { $0.id }

                print("\n🐶 Dog Data Updated in RecipeListView:")
                print("Name: \(updatedDog.name)")
                print("Recipe IDs: \(updatedDog.recipeIDs)")
                print("Matched Recipes: \(viewModel.recipes.filter { updatedDog.recipeIDs.contains($0.id) }.map { $0.title })\n")
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}


struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = RecipeViewModel()

        var sampleDog = Dog(name: "Buddy", breed: "Golden Retriever", age_years: 5, gender: "Male", chronic_conditions: ["None"])
        sampleDog.recipeIDs = viewModel.recipes.map { $0.id }

        return RecipeListView(dog: sampleDog)
            .environmentObject(viewModel)
    }
}
