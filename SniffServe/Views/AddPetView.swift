//
//  AddPetView.swift
//  SniffServe
//
//  Used PetInputFormView

import SwiftUI

struct AddPetView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var petName = ""
    @State private var petAge = ""
    @State private var petBreed = ""
    @State private var petGender = ""
    @State private var petConditions = ""

    var body: some View {
        PetInputFormView(
            petName: $petName,
            petAge: $petAge,
            petBreed: $petBreed,
            petGender: $petGender,
            petConditions: $petConditions,
            onSave: {
                print("New pet added! Name: \(petName), Age: \(petAge), Breed: \(petBreed), Gender: \(petGender), Conditions: \(petConditions)")
                dismiss()
            },
            onCancel: {
                print("Add pet canceled!")
                dismiss()
            },
            formTitle: "Create Pet Profile",
            petPhoto: "add photo",
            petPhotoOpacity: 0.7
        )
    }
}


#Preview {
    AddPetView()
}
