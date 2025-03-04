//
//  PetListView.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/7/25.
//

import SwiftUI

struct PetListView: View {
    var body: some View {
        BaseView(
            topRightIcon: "plus"
        ) {
            MainBodyView()
        }
    }
}

struct MainBodyView: View {
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

    var body: some View {
        VStack {
            ForEach(dogViewModel.dogs) { dog in
                NavigationLink(destination: PetProfileView(dog: dog)) {
                    DogCardView(dog: dog, deleteAction: {
                        if let index = dogViewModel.dogs.firstIndex(where: { $0.id == dog.id }) {
                            dogViewModel.deleteDog(at: IndexSet(integer: index))
                        }
                    })
                }
                .padding(.bottom, 10)
            }
            
            if dogViewModel.dogs.count == 0 {
                Text("No dogs found")
                    .font(.title)
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
