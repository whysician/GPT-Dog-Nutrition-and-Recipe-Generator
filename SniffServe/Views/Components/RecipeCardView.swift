//
//  RecipeViewModel.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/7/25.
//

import SwiftUI

struct RecipeCardView: View {
    var recipe: Recipe
    var deleteAction: () -> Void

    var body: some View {
        HStack {
            Text(recipe.title)
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(.black)
                .padding(.leading, 10)
            Spacer()
            Button(action: deleteAction) {
                Image(systemName: "trash.fill")
                    .foregroundColor(.red)
                    .font(.title)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.trailing, 20)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.923))
        .cornerRadius(20)
        .padding(.horizontal, 12)
    }
}
