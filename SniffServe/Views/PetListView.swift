//
//  PetListView.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/7/25.
//

import SwiftUI

struct PetListView: View {
    @EnvironmentObject var dogViewModel: DogViewModel
    @StateObject var recipeViewModel = RecipeViewModel() // ✅ Ensure RecipeViewModel exists

    var body: some View {
        NavigationStack {
            BaseView(
                topLeftIcon: "chevron.backward",
                topRightIcon: "plus"
            ) {
                MainBodyView()
            }
        }
        .environmentObject(recipeViewModel) // ✅ Pass RecipeViewModel globally
    }
}



struct MainBodyView: View {
    @EnvironmentObject var dogViewModel: DogViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 30) {
                CircleImage(size: 120)
                    .padding(.top, 35)
                
                Text("Your Dogs")
                    .font(.system(size: 35))
                    .padding(.bottom)
                
                DogListView()
            }
        }
    }
}

struct DogListView: View {
    @EnvironmentObject var dogViewModel: DogViewModel
    @EnvironmentObject var recipeViewModel: RecipeViewModel // ✅ Get RecipeViewModel

    var body: some View {
        VStack {
            ForEach(dogViewModel.dogs, id:\.self) { dog in
                NavigationLink(destination: PetProfileView(dog: dog)
                    .environmentObject(recipeViewModel) // ✅ Pass RecipeViewModel
                ) {
                    DogCardView(dog: dog, deleteAction: {
                        if let index = dogViewModel.dogs.firstIndex(where: { $0.id == dog.id }) {
                            dogViewModel.deleteDog(at: IndexSet(integer: index))
                        }
                    })
                }
                .padding(.bottom, 10)
            }
        }
    }
}


struct PetListView_Previews: PreviewProvider {
    static var previews: some View {
        PetListView()
    }
}

