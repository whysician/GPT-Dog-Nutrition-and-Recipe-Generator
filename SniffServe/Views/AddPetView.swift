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

    var body: some View {
        PetInputFormView(
            // Add pet functionality: save/cancel
            onSave: {
                print("New pet added!")
                presentationMode.wrappedValue.dismiss()
            },
            onCancel: {
                print("Add pet canceled")
                presentationMode.wrappedValue.dismiss()
            },
            formTitle: "Create Pet Profile",
            petTitle: "add photo",
            petTitleOpacity: 0.4
        )
    }
}


#Preview {
    AddPetView()
}
