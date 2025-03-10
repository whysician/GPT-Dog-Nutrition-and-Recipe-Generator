//
//  PetListView.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/7/25.
//

import SwiftUI

struct PetListView: View {
    @EnvironmentObject var dogViewModel: DogViewModel
    @State private var showingAddPetView = false
    
    var body: some View {
        NavigationStack {
            BaseView(
                topRightIcon: "plus",
                topRightAction: { showingAddPetView = true }
            ) {
                MainBodyView()
            }
            .navigationDestination(isPresented: $showingAddPetView) {
                AddPetView()
                    .environmentObject(dogViewModel)
            }
        }
    }
}

struct MainBodyView: View {
    var body: some View {
        // Creates static image of dog icon and the title of the list
        ScrollView {
            LazyVStack(spacing: 30) {
                CircleImage(size: 110)
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

    var body: some View {
        // Creates the actual list of dog that can be selected
        VStack {
            ForEach(dogViewModel.dogs) { dog in
                NavigationLink(destination: PetProfileView(dog: dog)) {
                    DogCardView(dog: dog, deleteAction: {
                        // Determines the index of the proper dog to delete within the dog list of the viewmodel
                        if let index = dogViewModel.dogs.firstIndex(where: { $0.id == dog.id }) {
                            dogViewModel.deleteDog(at: IndexSet(integer: index))
                        }
                    })
                }
                .padding(.bottom, 10)
            }
            
            // Message to show when no dogs are in the list
            if dogViewModel.dogs.count == 0 {
                Text("No dogs found\nClick + to start")
                    .font(.title)
                    .padding(.top, 60)
            }
        }
    }
}

struct PetListView_Previews: PreviewProvider {
    static var previews: some View {
        PetListView()
            .environmentObject(DogViewModel())
    }
}
