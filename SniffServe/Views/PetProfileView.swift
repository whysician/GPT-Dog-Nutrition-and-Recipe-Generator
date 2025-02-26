//
//  PetProfileView.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/7/25.
//

import SwiftUI

struct PetProfileView: View {
    @EnvironmentObject var dogViewModel: DogViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showingRecipes = false
    @State private var showingChat = false
    var dog: Dog

    var body: some View {
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
            if let index = dogViewModel.dogs.firstIndex(where: { $0.id == dog.id }) {
                RecipeListView(dog: dogViewModel.dogs[index]) // ✅ Pass latest dog object
                    .environmentObject(dogViewModel)
            }
        }
        .navigationDestination(isPresented: $showingChat) {
            ChatView(dog: dog)
                .environmentObject(dogViewModel)
        }
    }
}

struct PetView: View {
    var dog: Dog

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                CircleImage(size: 200)
                    .padding(.top, 35)
                    .padding(.bottom, 30)

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
                            .fill(Color.blue.opacity(0.3))
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
                            .fill(Color.red.opacity(0.3))
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
                            VStack(alignment: .leading, spacing: 10) {
                                ForEach(dog.chronic_conditions, id: \.self) { condition in
                                    HStack(alignment: .top) {
                                        Text("•")
                                            .font(.system(size: 17))
                                        Text(condition)
                                    }
                                }
                            }
                            .padding()
                        }
                        .background(Color.orange.opacity(0.3))
                        .cornerRadius(10)
                        .padding(.horizontal)
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
        let dogViewModel = DogViewModel()

        return NavigationStack {
            PetProfileView(dog: dogViewModel.dogs.first ?? Dog(
                name: "Daisy",
                breed: "French Bulldog",
                age_years: 14,
                gender: "Female",
                chronic_conditions: ["Blind in one eye", "Kidney issues", "Trouble walking"]
            ))
            .environmentObject(dogViewModel) // ✅ Ensure DogViewModel is passed
        }
    }
}
