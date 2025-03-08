//
//  PetInputFormView.swift
//  SniffServe
//
//  Purpose: A reusable form component for both AddPetView and EditPetView.

import SwiftUI

struct PetInputFormView: View {
    @Binding var petName: String
    @Binding var petAge: String
    @Binding var petBreed: String
    @Binding var petGender: String
    @Binding var petConditions: String
    @Binding var petImage: UIImage?
    @State private var showImagePicker = false

    var onSave: () -> Void
    var onCancel: () -> Void
    var formTitle: String
    var petPhoto: String
    var petPhotoOpacity: Double = 1.0
    var conditionsPlaceholder: String

    var body: some View {
        BaseView(
            screenTitle: formTitle,
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
            VStack(spacing: 10) {
                
                // Pet image picker section
                Button(action: { showImagePicker.toggle() }) {
                    ZStack {
                        Circle()
                            .fill(Color(.systemTeal).opacity(0.3))
                            .frame(width: 100, height: 100)

                        // Display selected image if available
                        if let petImage = petImage {
                            Image(uiImage: petImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                        } else {
                            // Default placeholder SF symbol image
                            Image(systemName: "photo.on.rectangle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 45, height: 45)
                                .foregroundColor(.black)
                        }
                    }
                }
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(selectedImage: $petImage)
                }
                Text(petPhoto)
                    .font(.headline)
                    .foregroundColor(.black)
                    .opacity(petPhotoOpacity)

                // Input form fields section
                VStack(alignment: .leading, spacing: 16) {
                    CustomTextField(label: "Name", text: $petName, placeholder: "e.g. Doge")
                    CustomTextField(label: "Age", text: $petAge, keyboardType: .numberPad, placeholder: "e.g. 3")
                    CustomTextField(label: "Breed", text: $petBreed, placeholder: "e.g. Shiba Inu")
                    CustomTextField(label: "Gender", text: $petGender, placeholder: "e.g. Male")
                    CustomMultilineTextField(label: "Chronic Conditions", text: $petConditions, placeholder: conditionsPlaceholder)
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

// Single-line input field with a label
struct CustomTextField: View {
    var label: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var fieldWidth: CGFloat = 280
    var placeholder: String

    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            // Field label
            Text(label)
                .frame(width: 60, alignment: .leading)
                .font(.body)
                .foregroundColor(.black)

            // Input field
            TextField(placeholder, text: $text)
                .keyboardType(keyboardType)
                .padding()
                .frame(width: fieldWidth, height: 50)
                .background(Color(.systemTeal).opacity(0.2))
                .cornerRadius(8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// Multiline text input field
struct CustomMultilineTextField: View {
    var label: String
    @Binding var text: String
    var fieldWidth: CGFloat = 320
    var placeholder: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            // Field label
            Text(label)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.body)
                .foregroundColor(.black)
            
            // Text editor with placeholder functionality 
            ZStack(alignment: .topLeading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.gray)
                        .padding(15)
                        .allowsHitTesting(false)
                }
                
                TextEditor(text: $text)
                    .frame(width: fieldWidth, height: 100)
                    .padding()
                    .background(Color(.systemTeal).opacity(0.3))
                    .cornerRadius(8)
                    .opacity(text.isEmpty ? 0.2 : 1)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(.systemTeal).opacity(text.isEmpty ? 0.5 : 0.0), lineWidth: 1)
                    )
                    
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}


#Preview {
    @Previewable @State var previewPetName = ""
    @Previewable @State var previewPetAge = ""
    @Previewable @State var previewPetBreed = ""
    @Previewable @State var previewPetGender = ""
    @Previewable @State var previewPetConditions = ""
    @Previewable @State var previewPetImage: UIImage? = nil

    PetInputFormView(
        petName: $previewPetName,
        petAge: $previewPetAge,
        petBreed: $previewPetBreed,
        petGender: $previewPetGender,
        petConditions: $previewPetConditions,
        petImage: $previewPetImage,
        onSave: {},
        onCancel: {},
        formTitle: "<Title Name>",
        petPhoto: "add photo",
        conditionsPlaceholder: "<Chronic condition inputs goes here>"
    )
}
