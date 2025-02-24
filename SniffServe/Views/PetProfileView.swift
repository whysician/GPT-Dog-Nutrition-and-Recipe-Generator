//
//  PetProfileView.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/7/25.
//

import SwiftUI

struct PetProfileView: View {
    var dog: Dog
    @Environment(\.dismiss) private var dismiss
    @State private var showingRecipes = false
    @State private var showingChat = false
    @StateObject private var viewModel = RecipeViewModel()

    var body: some View {
        NavigationStack {
            BaseView(
                screenTitle: "Dog Profile",
                topLeftIcon: "chevron.backward",
                topLeftAction: { dismiss() },
                topRightIcon: "pencil",
                botLeftIcon: "book.closed.fill",
                botLeftAction: { showingRecipes = true },
                botRightIcon: "bubble",
                botRightAction: { showingChat = true }
            ) {
                PetView(dog: dog)
            }
            .navigationDestination(isPresented: $showingRecipes) {
                let updatedDog = Dog(
                    name: dog.name,
                    breed: dog.breed,
                    age_years: dog.age_years,
                    gender: dog.gender,
                    chronic_conditions: dog.chronic_conditions,
                    recipeIDs: viewModel.recipes.map { $0.id }
                )
                RecipeListView(dog: updatedDog)
                    .environmentObject(viewModel)
            }
            .navigationDestination(isPresented: $showingChat) {
                ChatView(dog: dog)
                    .environmentObject(viewModel)
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}

struct PetView: View {
    var dog: Dog

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                if UIImage(named: "Doge") != nil {
                    CircleImage(imageName: "Doge", size: 200)
                        .padding(.top, 35)
                        .padding(.bottom, 30)
                } else {
                    CircleImage(size: 100)
                        .padding(.top, 35)
                        .padding(.bottom, 30)
                }

                VStack {
                    Text(dog.name)
                        .font(.system(size: 45))
                        .fontWeight(.semibold)

                    Text(dog.breed)
                        .font(.title)
                        .fontWeight(.light)
                }
                .offset(y: -20)

                HStack {
                    ZStack {
                        Rectangle()
                            .fill(Color(hue: 0.542, saturation: 0.701, brightness: 0.973).opacity(0.3))
                            .frame(height: 120)
                            .cornerRadius(20)

                        Text("Age")
                            .offset(y: -30)
                            .fontWeight(.semibold)
                            .font(.system(size: 20))

                        Text("\(dog.age_years) years,")
                            .font(.system(size: 20))
                        Text("\(dog.age_months) months")
                            .offset(y: 25)
                            .font(.system(size: 20))
                    }

                    Spacer(minLength: 50)

                    ZStack {
                        Rectangle()
                            .fill(Color.red).opacity(0.3)
                            .frame(height: 120)
                            .cornerRadius(20)

                        Text("Gender")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .offset(y: -30)

                        Text(dog.gender)
                            .font(.system(size: 20))
                            .offset(y: 5)
                    }
                }
                .padding(.horizontal)

                Spacer()

                VStack(spacing: 5.0) {
                    if dog.chronic_conditions.isEmpty {
                        Text("Chronic Conditions: None")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } else {
                        Text("Chronic Conditions")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        ZStack {
                            VStack(alignment: .leading, spacing: 10){
                                ForEach(dog.chronic_conditions, id: \.self) { data in
                                    HStack(alignment: .top) {
                                        Text("\u{2022}")
                                            .font(.system(size: 17))
                                        Text(data)
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 10)
                            .padding(.leading, 10)
                            .padding(.trailing, 30)
                        }
                        .padding(.horizontal, 10)
                        .padding(.top, 0)
                        .frame(maxWidth: .infinity)
                        .background(alignment: .bottom) {
                            Color.orange.opacity(0.3)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                    }
                }
            }
            .padding(.horizontal, 15)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct PetProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = RecipeViewModel()
        let sampleRecipes = viewModel.recipes.map { $0.id }

        PetProfileView(dog: Dog(
            name: "Daisy",
            breed: "French Bulldog",
            age_years: 14,
            gender: "Female",
            chronic_conditions: ["Blind in one eye", "Kidney issues", "Trouble walking"],
            recipeIDs: sampleRecipes
        ))
        .environmentObject(viewModel)
    }
}
