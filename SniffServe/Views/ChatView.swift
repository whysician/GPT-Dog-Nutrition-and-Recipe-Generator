//
//  ChatView.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/7/25.
//

import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel = OpenAIViewModel()
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    @State private var selectedDog = Dog(name: "Buddy", breed: "Labrador", age_years: 3, gender: "Male")

    var body: some View {
        VStack {
            // Header
            HStack {
                Button(action: {}) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.black)
                        .font(.title)
                }
                .padding(.leading, 10)

                Spacer()

                Text("Chat with AI")
                    .font(.title)
                    .bold()

                Spacer()
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)

            // Chat messages display
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(viewModel.messages) { message in
                        MessageView(message: message)
                    }
                }
            }
            .padding()

            // Message input area
            HStack {
                TextField("Type your message here...", text: $viewModel.userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Send") {
                    viewModel.sendMessage()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()

            // Generate recipe button
            Button("Generate Recipe for Dog") {
                viewModel.generateRecipeForDog(dog: selectedDog)
            }
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(10)

            // Conditional save recipe button
            if viewModel.showSaveRecipeOption, let recipe = viewModel.lastGeneratedRecipe {
                Button("Save Recipe") {
                    recipeViewModel.addRecipe(recipe)
                    viewModel.showSaveRecipeOption = false
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView().environmentObject(RecipeViewModel())
    }
}
