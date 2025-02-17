//
//  RecipeListView.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/7/25.
//

import SwiftUI

struct RecipeListView: View {
    @ObservedObject var viewModel: RecipeViewModel

    var body: some View {
        NavigationView {
            BaseView(
                screenTitle: "Recipes",
                topLeftIcon: "chevron.backward",
                topLeftAction: {
                    // For future navigation
                }
            ) {
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(viewModel.recipes) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                RecipeCardView(recipe: recipe, deleteAction: {
                                    if let index = viewModel.recipes.firstIndex(where: { $0.id == recipe.id }) {
                                        viewModel.deleteRecipes(at: IndexSet(integer: index))
                                    }
                                })
                            }
                        }
                    }
                    .padding(.top, 10)
                }
            }
        }
    }

    private func deleteRecipe(at offsets: IndexSet) {
        viewModel.deleteRecipes(at: offsets)
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView(viewModel: RecipeViewModel())
    }
}
