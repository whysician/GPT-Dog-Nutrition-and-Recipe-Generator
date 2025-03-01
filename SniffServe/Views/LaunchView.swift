//
//  LaunchView.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/7/25.
//

import SwiftUI

struct LaunchView: View {
    
    @State private var sniffServe: [String] = "SniffServe".map { String($0) }
    @State private var showSniff: Bool = false
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    @Binding var showLaunchView:  Bool
    
    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            
            Image(systemName: "dog.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .offset(y: 10)

            
            ZStack {
                if showSniff {
                    HStack(spacing: 0) {
                        ForEach(sniffServe.indices, id: \.self) { index in
                            Text(sniffServe[index])
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.black)
                                .offset(y: counter == index ? -20 : 0)
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeIn))
                }
            }
            .offset(y: 90)
        }
        .onAppear {
            showSniff.toggle()
        }
        .onReceive(timer, perform: { _ in
            withAnimation(.spring()) {
                let lastIndex = sniffServe.count - 1
                
                if counter == lastIndex {
                    counter = 0
                    loops += 1
                    
                    if loops >= 2 {
                        showLaunchView = false
                    }
                } else {
                    counter += 1
                }
            }
        })
    }
}


struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchView: .constant(true))
    }
}
