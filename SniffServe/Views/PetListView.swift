//
//  PetListView.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/7/25.
//

import SwiftUI

struct PetListView: View {
    // When dynamically populating list, assign this variable to dynamic list
    let dogList: [Dog]
    
    var body: some View {
        BaseView(
            topLeftIcon: "chevron.backward",
            topRightIcon: "plus"
        ) {
            ScrollView {
                LazyVStack(spacing: 30) {
                    CircleImage(size: 120)
                        .padding(.top, 35)
                    
                    Text("Steven" + "'s Dogs")   // Placeholder name
                        .font(.system(size: 35))
                        .padding(.bottom)
                    
                    VStack {
                        ForEach(dogList) { dog in
                            DogCard( dog: dog)
                                .padding(.bottom, 10)
                        }
                    }
                }
            }
        }
    }
}


struct PetListView_Previews: PreviewProvider {
    static var previews: some View {
        // Placeholder list
        PetListView(dogList: [
            Dog(name: "Test Dog 1", breed: "Test Breed 1", age_years: 2, age_months: 8, gender: "female"),
            Dog(name: "Test Dog 2", breed: "Test Breed 2", age_years: 3, gender: "male"),
            Dog(name: "Test Dog 3", breed: "Test Breed 3", age_months: 8, gender: "male"),
            Dog(name: "Test Dog 4", breed: "Test Breed 4", age_years: 12, gender: "female")
        ])
    }
}
