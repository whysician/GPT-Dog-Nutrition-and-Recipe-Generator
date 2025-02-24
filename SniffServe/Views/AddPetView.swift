//
//  AddPetView.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/16/25.
//
//  Used PetInputFormView

import SwiftUI

struct AddPetView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var dogViewModel: DogViewModel

    @State private var petName: String = ""
    @State private var petAgeYears: String = ""
    @State private var petBreed: String = ""
    @State private var petGender: String = ""
    @State private var petConditions: String = ""

    var body: some View {
        PetInputFormView(
            petName: $petName,
            petAge: $petAgeYears,
            petBreed: $petBreed,
            petGender: $petGender,
            petConditions: $petConditions,
            onSave: savePet,
            onCancel: {
                print("Add pet canceled")
                presentationMode.wrappedValue.dismiss()
            },
            formTitle: "Create Pet Profile",
            petTitle: "Add Photo",
            petTitleOpacity: 0.4
        )
    }

    private func savePet() {
        let newDog = Dog(
            name: petName,
            breed: petBreed,
            age_years: Int(petAgeYears) ?? 0,
            gender: petGender,
            chronic_conditions: petConditions.isEmpty ? [] : petConditions.split(separator: ",").map { String($0.trimmingCharacters(in: .whitespacesAndNewlines)) }
        )
        dogViewModel.addDog(newDog)
        print("New pet added!")
        printPetDetails(newDog)
        printAllDogsNames()
        presentationMode.wrappedValue.dismiss()
    }

    private func printPetDetails(_ dog: Dog) {
        print("Pet Name: \(dog.name)")
        print("Breed: \(dog.breed)")
        print("Age (Years): \(dog.age_years)")
        print("Gender: \(dog.gender)")
        print("Chronic Conditions: \(dog.chronic_conditions)")
    }

    private func printAllDogsNames() {
        print("All saved dogs' names:")
        for dog in dogViewModel.dogs {
            print(dog.name)
        }
    }
}

struct AddPetView_Previews: PreviewProvider {
    static var previews: some View {
        AddPetView().environmentObject(DogViewModel())
    }
}
