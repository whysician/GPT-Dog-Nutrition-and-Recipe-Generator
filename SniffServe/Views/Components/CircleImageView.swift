//
//  CircleImage.swift
//  SniffServe
//
//  Created by Sebastian on 2/12/25.
//

import SwiftUI

struct CircleImage: View {
    var imageName: String = ""
    var size: CGFloat
    
    var body: some View {
        if imageName != "" {
            Circle()
                .stroke(.white, lineWidth: 10)
                .fill(.white)
                .overlay(
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                )
                .frame(width: size, height: size)
        } else {
            Circle()
                .stroke(.white, lineWidth: 10)
                .fill(.white)
                .overlay(
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .padding(2)
                        .clipShape(Circle())
                )
                .frame(width: size, height: size)
        }
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(size: 200)
    }
}
