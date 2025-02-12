//
//  DogCardView.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/7/25.
//

import SwiftUI

struct DogCard: View {
    let dog: Dog
    
    var body: some View {
        HStack {
            if UIImage(named: "Doge") != nil {
                CircleImage(imageName: "Doge", size: 200)
                    .padding(.top, 35)
                    .padding(.bottom, 30)
                    .padding(.leading, 10)
            } else {
                CircleImage(size: 50)
                    .padding(.top, 35)
                    .padding(.bottom, 30)
                    .padding(.leading, 25)
            }
            
            Text(dog.name)
                .font(.system(size: 22, weight: .semibold))
                .padding(.leading, 10)
            
            Spacer()
            Button {
                // TODO
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


struct DogCardView_Previews: PreviewProvider {
    static var testDog = Dog(name: "Test Dog", breed: "Test Breed", age_years: 2, age_months: 8, gender: "female")
    
    static var previews: some View {
        DogCard(dog: testDog)
            .previewLayout(.fixed(width: 500, height: 150))
    }
}
