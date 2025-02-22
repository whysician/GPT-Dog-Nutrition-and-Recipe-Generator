//
//  PetInputFormView.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/16/25.
//

import SwiftUI

struct PetInputFormView: View {
    @State private var petName = ""
    @State private var petAge = ""
    @State private var petBreed = ""
    @State private var petGender = ""
    @State private var petConditions = ""
    @State private var petImage: UIImage? = nil

    var onSave: () -> Void
    var onCancel: () -> Void

    var body: some View {
        BaseView(
            screenTitle: "Create Dog Profile",
            topLeftIcon: "chevron.backward",
            topLeftAction: onCancel,
            botLeftIcon: "checkmark",
            botLeftAction: {
                print("Saved pet: \(petName), \(petAge), \(petBreed), \(petGender), \(petConditions)")
                onSave()
            },
            botRightIcon: "xmark",
            botRightAction: onCancel
        ) {
            // Pet Picture
            VStack(spacing: 1) {
                    VStack {
                        ZStack {
                            Circle()
                                .fill(Color(.systemTeal).opacity(0.3))
                                .frame(width: 80, height: 80)
                            
                            Image(systemName: "photo.on.rectangle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.black)
                        }
                        Text("<pet name>")
                            .font(.headline)
                            .foregroundColor(.black)
                    }
                

                // Input Fields
                VStack(alignment: .leading, spacing: 12) {
                    CustomTextField(label: "Name", text: $petName, fieldWidth: 250)
                    CustomTextField(label: "Age", text: $petAge, keyboardType: .numberPad, fieldWidth: 250)
                    CustomTextField(label: "Breed", text: $petBreed, fieldWidth: 250)
                    CustomTextField(label: "Gender", text: $petGender, fieldWidth: 250)
                    CustomTextField(label: "Chronic Conditions", text: $petConditions, isMultiline: true, fieldWidth: 220)
                }
                .padding(.horizontal)
                .padding(.top, 20)
            }
        }
    }
}

// Custom text field view with labels and inputs aligned to the left
struct CustomTextField: View {
    var label: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var isMultiline: Bool = false
    var fieldWidth: CGFloat = 200  // Default width for text input

    var body: some View {
        HStack(alignment: .top) {
            Text(label)
                .frame(width: 70, alignment: .leading) // Adjust label width
                .font(.body)
                .foregroundColor(.black)

            if isMultiline {
                TextEditor(text: $text)
                    .frame(width: fieldWidth, height: 90)
                    .padding()
                    .background(Color(.systemTeal).opacity(0.2))
                    .cornerRadius(8)
            } else {
                CustomTextField(label: "", text: $text)
                    .keyboardType(keyboardType)
                    .padding()
                    .frame(width: fieldWidth, alignment: .leading)
                    .background(Color(.systemTeal).opacity(0.2))
                    .cornerRadius(8)
            }
        }
    }
}


// SwiftUI Preview with an Empty Form
#Preview {
    PetInputFormView(
        onSave: {},
        onCancel: {}
    )
}
