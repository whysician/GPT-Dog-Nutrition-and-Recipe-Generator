//
//  MessageView.swift
//  SniffServe
//
//  Created by Eric Tolson on 2/18/25.
//

import SwiftUI

//Displays a single chat message, styled differently based on the sender.
struct MessageView: View {
    var message: ChatMessage

    var body: some View {
        HStack {
            if message.role == "user" {
                Spacer()
                Text(message.content)
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(10)
                    .foregroundColor(Color.black)
            } else {
                Text(message.content)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .foregroundColor(Color.black)
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}


struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: ChatMessage(role: "user", content: "Hello, World!"))
            .previewLayout(.sizeThatFits)
    }
}
