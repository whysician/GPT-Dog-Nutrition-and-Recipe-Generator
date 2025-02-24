//
//  EditPetView.swift
//  SniffServe
//
//  Created by Eric Tolson on 2/15/25.
//

import SwiftUI

struct EditPetView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var dogViewModel: DogViewModel
    @Binding var dog: Dog

    var body: some View {
        PetInputFormView(
            petName: $dog.name,
            petAge: Binding<String>(
                get: { String(dog.age_years) },
                set: { dog.age_years = Int($0) ?? dog.age_years }
            ),
            petBreed: $dog.breed,
            petGender: $dog.gender,
            petConditions: Binding<String>(
                get: { dog.chronic_conditions.joined(separator: ", ") },
                set: { dog.chronic_conditions = $0.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) } }
            ),
            onSave: updatePet,
            onCancel: {
                print("Edit pet canceled")
                presentationMode.wrappedValue.dismiss()
            },
            formTitle: "Edit Pet Profile",
            petTitle: "Update Photo",
            petTitleOpacity: 0.4
        )
    }

    private func updatePet() {
        if let index = dogViewModel.dogs.firstIndex(where: { $0.id == dog.id }) {
            dogViewModel.updateDog(dog, at: index)
        }
        print("Pet updated!")
        printPetDetails(dog)
        presentationMode.wrappedValue.dismiss()
    }

    private func printPetDetails(_ dog: Dog) {
        print("Updated Pet Details:")
        print("Name: \(dog.name)")
        print("Breed: \(dog.breed)")
        print("Age (Years): \(dog.age_years)")
        print("Gender: \(dog.gender)")
        print("Chronic Conditions: \(dog.chronic_conditions)")
    }
}

struct EditPetView_Previews: PreviewProvider {
    static var previews: some View {
        let dogViewModel = DogViewModel()

        if dogViewModel.dogs.isEmpty {
            dogViewModel.dogs = [
                Dog(name: "Buddy", breed: "Golden Retriever", age_years: 3, age_months: 6, gender: "Male", chronic_conditions: ["Healthy"]),
                Dog(name: "Lucy", breed: "Labrador", age_years: 2, gender: "Female", chronic_conditions: ["Anxious"])
            ]
        }

        return StatefulPreviewWrapper(dogViewModel.dogs.first!) { dog in
            EditPetView(dog: dog)
                .environmentObject(dogViewModel)
        }
    }
}

struct StatefulPreviewWrapper<Value: Identifiable, Content: View>: View {
    @State private var value: Value
    let content: (Binding<Value>) -> Content

    init(_ initialValue: Value, @ViewBuilder content: @escaping (Binding<Value>) -> Content) {
        self._value = State(initialValue: initialValue)
        self.content = content
    }

    var body: some View {
        content($value)
    }
}
