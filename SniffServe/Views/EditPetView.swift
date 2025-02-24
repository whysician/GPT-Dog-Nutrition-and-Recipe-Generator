//
//  EditPetView.swift
//  SniffServe
//

import SwiftUI

struct EditPetView: View {
    @Binding var dog: Dog
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: DogViewModel

    @State private var petName: String = ""
    @State private var petAge: String = ""
    @State private var petBreed: String = ""
    @State private var petGender: String = ""
    @State private var petConditions: String = ""

    init(dog: Binding<Dog>) {
        self._dog = dog
        _petName = State(initialValue: dog.wrappedValue.name)
        _petAge = State(initialValue: "\(dog.wrappedValue.age_years)")
        _petBreed = State(initialValue: dog.wrappedValue.breed)
        _petGender = State(initialValue: dog.wrappedValue.gender)
        _petConditions = State(initialValue: dog.wrappedValue.chronic_conditions
            .map {"• " + $0}
            .joined(separator: "\n"))
    }

    var body: some View {
        PetInputFormView(
            petName: $petName,
            petAge: $petAge,
            petBreed: $petBreed,
            petGender: $petGender,
            petConditions: $petConditions,
            onSave: {
                if let index = viewModel.dogs.firstIndex(where: { $0.id == dog.id }) {
                    viewModel.dogs[index].name = petName
                    viewModel.dogs[index].age_years = Int(petAge) ?? 0
                    viewModel.dogs[index].breed = petBreed
                    viewModel.dogs[index].gender = petGender
                    viewModel.dogs[index].chronic_conditions = petConditions
                        .split(separator: "\n")
                        .map { $0.replacingOccurrences(of: "• ", with: "").trimmingCharacters(in: .whitespaces) }
                    
                    dismiss()
                }
            },
            onCancel: { dismiss() },
            formTitle: "Edit Pet Profile",
            petPhoto: "edit photo",
            petPhotoOpacity: 0.7
        )
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
