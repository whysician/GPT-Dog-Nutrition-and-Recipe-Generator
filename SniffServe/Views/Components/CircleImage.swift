//
//  CircleImage.swift
//  SniffServe
//
//  Created by Victoria Sok on 3/4/25.
//

import SwiftUI

struct CircleImage: View {
    var size: CGFloat
    var imageName: String = "dog.circle.fill"

    var body: some View {
        // Create the static dog circle image for each card shown in PetListView
        Image(systemName: imageName)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .clipShape(Circle())
            .foregroundColor(.gray)
    }
}


struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(size: 100)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
