//
//  EditPetView.swift
//  SniffServe
//
// Purpose: Allows users to edit an existing pet's details using the resuable PetInputInformView.

import SwiftUI

struct EditPetView: View {
    @Binding var dog: Dog
    @EnvironmentObject var viewModel: DogViewModel

    @State private var petName: String = ""
    @State private var petAge: String = ""
    @State private var petBreed: String = ""
    @State private var petGender: String = ""
    @State private var petConditions: String = ""
    @State private var navigateToProfile = false
    @State private var petImage: UIImage? = nil

    // Pre-fills the form with the pet's existing details
    init(dog: Binding<Dog>) {
        self._dog = dog
        _petName = State(initialValue: dog.wrappedValue.name)
        _petAge = State(initialValue: "\(dog.wrappedValue.age_years)")
        _petBreed = State(initialValue: dog.wrappedValue.breed)
        _petGender = State(initialValue: dog.wrappedValue.gender)
        _petConditions = State(initialValue: dog.wrappedValue.chronic_conditions
            .map {"• " + $0}    // Adds bullet points to each condition
            .joined(separator: "\n"))   // Joins them into a multi-line string by new line separator
    }

    var body: some View {
        NavigationStack {
            PetInputFormView(
                petName: $petName,
                petAge: $petAge,
                petBreed: $petBreed,
                petGender: $petGender,
                petConditions: $petConditions,
                petImage: $petImage,
                onSave: {
                    if let index = viewModel.dogs.firstIndex(where: { $0.id == dog.id }) {
                        viewModel.dogs[index].name = petName
                        viewModel.dogs[index].age_years = Int(petAge) ?? 0
                        viewModel.dogs[index].breed = petBreed
                        viewModel.dogs[index].gender = petGender
                        // Converts multi-line conditions back to an array
                        viewModel.dogs[index].chronic_conditions = petConditions
                            .split(separator: "\n")
                            .map { $0.replacingOccurrences(of: "• ", with: "").trimmingCharacters(in: .whitespaces) }
                        viewModel.saveDogList()
                        
                        print("Pet info updated: \(petName), Age: \(petAge), Breed: \(petBreed), Gender: \(petGender), Conditions: \(viewModel.dogs[index].chronic_conditions)")
                        navigateToProfile = true
                    }
                },
                onCancel: {
                    print("Edit pet canceled!")
                    navigateToProfile = true
                },
                // Form display properties
                formTitle: "Edit Pet Profile",
                petPhoto: "edit photo",
                petPhotoOpacity: 0.7,
                conditionsPlaceholder: "Input a condition and press enter key to add a new one, or separate conditions."
            )
            .navigationDestination(isPresented: $navigateToProfile) {
                PetProfileView(dog: dog)
                    .environmentObject(viewModel)
            }
        }
        // On appear, update the input fields with the latest pet data
        .onAppear {
            petName = dog.name
            petAge = "\(dog.age_years)"
            petBreed = dog.breed
            petGender = dog.gender
            petConditions = dog.chronic_conditions
                .map {"• " + $0}
                .joined(separator: "\n")
        }
    }
}

#Preview {
    EditPetView(dog: .constant(Dog(name: "Daisy", breed: "French Bulldog", age_years: 14, gender: "Female", chronic_conditions: ["Blind in one eye", "Kidney issues", "Trouble walking"])))
        .environmentObject(DogViewModel())
}
