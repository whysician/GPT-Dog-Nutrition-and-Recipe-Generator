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
    @State private var showingSuccessAlert = false
    
    var body: some View {
        VStack(spacing: 0) {
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
                    .foregroundColor(.black)

                Spacer()
            }
            .padding()
            .background(Color.green)

            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(viewModel.messages) { message in
                        MessageView(message: message)
                    }
                }
            }
            .padding()

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

            Spacer()

            VStack(spacing: 20) {
                if viewModel.showSaveRecipeOption, let recipe = viewModel.lastGeneratedRecipe {
                    Button("Save Recipe") {
                        recipeViewModel.addRecipe(recipe)
                        viewModel.showSaveRecipeOption = false
                        showingSuccessAlert = true // Show success pop-up
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                }

                Button("Generate Recipe") {
                    viewModel.generateRecipeForDog(dog: selectedDog)
                }
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal, 20)
            }
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .edgesIgnoringSafeArea(.bottom)
        }
        .alert(isPresented: $showingSuccessAlert) {
            Alert(title: Text("Success"), message: Text("Recipe saved successfully!"), dismissButton: .default(Text("OK")))
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView().environmentObject(RecipeViewModel())
    }
}
