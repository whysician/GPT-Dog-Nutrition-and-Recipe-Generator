import SwiftUI

struct RecipeDetailView: View {
    var recipe: Recipe

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        BaseView(
            screenTitle: "Recipe Details",
            topLeftIcon: "chevron.backward",
            topLeftAction: {
                self.presentationMode.wrappedValue.dismiss()            }
        ) {
            ScrollView {
                VStack(alignment: .leading, spacing: 5) {
                    Text(recipe.title)
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, 5)

                    Text("Ingredients:")
                        .font(.headline)
                        .padding(.vertical, 5)

                    ForEach(recipe.ingredients, id: \.self) { ingredient in
                        Text("• \(ingredient)")
                            .padding(.bottom, 2)
                    }

                    Text("Instructions:")
                        .font(.headline)
                        .padding(.vertical, 5)

                    ForEach(recipe.instructions, id: \.self) { instruction in
                        Text(instruction)
                            .padding(.bottom, 2)
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe: Recipe(title: "Chicken Soup", ingredients: ["Chicken", "Water", "Carrots", "Celery"], instructions: ["Boil water", "Add chicken", "Simmer"]))
    }
}
