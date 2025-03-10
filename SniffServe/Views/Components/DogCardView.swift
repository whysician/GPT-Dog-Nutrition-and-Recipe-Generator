//
//  DogCardView.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/7/25.
//

import SwiftUI

struct DogCardView: View {
    var dog: Dog
    var deleteAction: () -> Void
    
    var body: some View {
        // Creates the cards that are shown in the PetListView
        HStack {
            CircleImage(size: 50)
                .foregroundStyle(.black)
                .padding(.top, 35)
                .padding(.bottom, 30)
                .padding(.leading, 25)

            
            Text(dog.name)
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(.black)
                .padding(.leading, 10)
            
            Spacer()
            Button {
                deleteAction()
            } label: {
                Image(systemName: "trash.fill")
                    .foregroundColor(.black)
                    .font(.largeTitle)
            }
            .padding(.trailing, 20)
        }
        .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.823))
        .cornerRadius(20)
        .padding(.horizontal, 12)
    }
}

