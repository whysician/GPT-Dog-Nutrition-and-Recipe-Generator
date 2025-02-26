//
//  ChatView.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/7/25.
//

import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel = OpenAIViewModel()
    @EnvironmentObject var dogViewModel: DogViewModel
    @Environment(\.dismiss) private var dismiss
    var dog: Dog
    @State private var showingSuccessAlert = false

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.black)
                        .font(.title)
                }
                .padding(.leading, 10)

                Spacer()

                Text("Chat with AI for \(dog.name)")
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
                        dogViewModel.addRecipe(recipe, to: dog)

                        viewModel.showSaveRecipeOption = false
                        showingSuccessAlert = true
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                }

                Button("Generate Recipe") {
                    viewModel.generateRecipeForDog(dog: dog)
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
        .navigationBarBackButtonHidden(true)
    }
}


struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        let dogViewModel = DogViewModel()

        return NavigationStack {
            ChatView(dog: dogViewModel.dogs.first ?? Dog(name: "Buddy", breed: "Labrador", age_years: 3, gender: "Male"))
                .environmentObject(dogViewModel) // ✅ Ensure DogViewModel is included
        }
    }
}
