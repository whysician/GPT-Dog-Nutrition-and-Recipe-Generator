//
//  AddPetView.swift
//  SniffServe
//
//  Used PetInputFormView

import SwiftUI

struct AddPetView: View {
    @EnvironmentObject var dogViewModel: DogViewModel

    @State private var petName = ""
    @State private var petAge = ""
    @State private var petBreed = ""
    @State private var petGender = ""
    @State private var petConditions = ""
    @State private var navigateToList = false

    var body: some View {
        NavigationStack {
            PetInputFormView(
                petName: $petName,
                petAge: $petAge,
                petBreed: $petBreed,
                petGender: $petGender,
                petConditions: $petConditions,
                onSave: {
                    let ageYears = Int(petAge) ?? 0
                    let conditionsList = petConditions
                        .split(separator: ",")
                        .map { $0.trimmingCharacters(in: .whitespaces) }
                        .filter { !$0.isEmpty }
                    
                    dogViewModel.addDog(
                        name: petName,
                        breed: petBreed,
                        ageYears: ageYears,
                        ageMonths: 0,       // Default to 0 for now
                        gender: petGender,
                        conditions: conditionsList
                    )
                    
                    print("New pet added: \(petName), Age: \(petAge), Breed: \(petBreed), Gender: \(petGender), Conditions: \(conditionsList)")
                    navigateToList = true
                },
                onCancel: {
                    print("Add pet canceled!")
                    navigateToList = true
                },
                formTitle: "Create Pet Profile",
                petPhoto: "add photo",
                petPhotoOpacity: 0.7,
                conditionsPlaceholder: "Enter conditions separated by commas (,).\n e.g. Hip Dysplasia, Allergies, etc."
            )
            .navigationDestination(isPresented: $navigateToList) {
                PetListView().environmentObject(dogViewModel)
            }
        }
    }
}


#Preview {
    AddPetView().environmentObject(DogViewModel())
}
