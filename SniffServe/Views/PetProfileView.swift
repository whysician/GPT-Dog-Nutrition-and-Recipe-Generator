//
//  PetProfileView.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/7/25.
//

import SwiftUI

struct PetProfileView: View {
    // Creates the pet profile screen for a specific dog
    
    @EnvironmentObject var dogViewModel: DogViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showingRecipes = false
    @State private var showingChat = false
    @State private var showingEditView = false
    @State var dog: Dog

    var body: some View {
        BaseView(
            screenTitle: "Dog Profile",
            topLeftIcon: "chevron.backward",
            topLeftAction: { dismiss() },
            topRightIcon: "pencil",
            topRightAction: { showingEditView = true },
            botLeftIcon: "book.closed.fill",
            botLeftAction: { showingRecipes = true },
            botRightIcon: "bubble",
            botRightAction: { showingChat = true }
        ) {
            PetView(dog: dog)
        }
        // Helps to ensure proper navigation for the app
        .navigationDestination(isPresented: $showingRecipes) {
            if let index = dogViewModel.dogs.firstIndex(where: { $0.id == dog.id }) {
                RecipeListView(dog: dogViewModel.dogs[index])
                    .environmentObject(dogViewModel)
            }
        }
        .navigationDestination(isPresented: $showingChat) {
            ChatView(dog: dog)
                .environmentObject(dogViewModel)
        }
        .navigationDestination(isPresented: $showingEditView) {
            EditPetView(dog: $dog)
                .environmentObject(dogViewModel)
        }
        .onAppear {
            if let updatedDog = dogViewModel.dogs.first(where: { $0.id == dog.id }) {
                dog = updatedDog
            }
        }
    }
}

struct PetView: View {
    var dog: Dog

    var body: some View {
        ScrollView {
            // Creates the static image of the dog icon and the dog's name and breed
            LazyVStack(spacing: 10) {
                CircleImage(size: 110)
                    .padding(.top, 35)
                    .padding(.bottom, 15)
                
                VStack {
                    Text(dog.name)
                        .font(.system(size: 45))
                        .fontWeight(.semibold)

                    Text(dog.breed)
                        .font(.title)
                        .fontWeight(.light)
                }
                .offset(y: -20)

                // Creates the rectangles and the information containing the age and gender of the dog
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

                        Text("\(dog.age_years) years")
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

                // Creates the rectangle and information showing chronic conditions of the dog
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
    }
}

struct PetProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let dogViewModel = DogViewModel()

        PetProfileView(dog: dogViewModel.dogs.first ?? Dog(
            name: "Daisy",
            breed: "French Bulldog",
            age_years: 14,
            gender: "Female",
            chronic_conditions: ["Blind in one eye", "Kidney issues", "Trouble walking"]
        ))
        .environmentObject(dogViewModel)
    }
}

