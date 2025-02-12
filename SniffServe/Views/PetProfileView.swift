//
//  PetProfileView.swift
//  SniffServe
//
//  Created by Victoria Sok on 2/7/25.
//

import SwiftUI

struct PetProfileView: View {
    var body: some View {
        BaseView(
            screenTitle: "Dog Profile",
            topLeftIcon: "chevron.backward",
            topRightIcon: "pencil",
            botLeftIcon: "book.closed.fill",
            botRightIcon: "bubble"
        ) {
            PetView()
        }
    }
}

struct PetView: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                if UIImage(named: "Doge") != nil {
                    CircleImage(imageName: "Doge", size: 200)
                        .padding(.top, 35)
                        .padding(.bottom, 30)
                } else {
                    CircleImage(size: 100)
                        .padding(.top, 35)
                        .padding(.bottom, 30)
                }
                
                VStack {
                    Text("Doge")   // Placeholder name
                        .font(.system(size: 45))
                        .fontWeight(.semibold)
                    
                    Text("Shiba Inu") // Placeholder breed
                        .font(.title)
                        .fontWeight(.light)
                        
                }
                .offset(y: -20)
                
                HStack {
                    
                    ZStack {
                        Rectangle()
                            .fill(Color(hue: 0.542, saturation: 0.701, brightness: 0.973).opacity(0.3))
                            .frame(height: 120)
                            .cornerRadius(20)
                        
                        Text("Age")
                            .offset(y: -30)
                            .fontWeight(.semibold)
                            .padding(.bottom, 1)
                            .font(.system(size: 20))
                        
                        Text("8" + " years,")  // Placeholder age (years)
                            .font(.system(size: 20))
                        Text("2" + " months")      // Placerholder age (months)
                            .offset(y: 25)
                            .font(.system(size: 20))
                    }
                    
                    Spacer(minLength: 50)
                    
                    ZStack {
                        Rectangle()
                            .fill(Color.red).opacity(0.3)
                            .frame(height: 120)
                            .cornerRadius(20)
                        

                        Text("Gender")
                            .fontWeight(.semibold)
                            .padding(.bottom, 1)
                            .font(.system(size: 20))
                            .offset(y: -30)
                    
                        Text("Male")     // Placeholder gender
                            .font(.system(size: 20))
                            .offset(y: 5)
                    

                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                VStack(spacing: 5.0) {
                    Text("Chronic Conditions")
                        .fontWeight(.semibold)
                        .font(.system(size: 20))
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ZStack {
                        VStack(alignment: .leading, spacing: 10){
                            // Placeholder chronic condition list
                            let chronicList: [String] = ["Crippling crypto additiction", "Bad Boy Syndrome", "Bad knees", "Test1", "Test2", "Test3"]
                            
                            ForEach(chronicList, id: \.self) { data in
                                HStack(alignment: .top) {
                                    Text("\u{2022}")
                                        .font(.system(size: 17))
                                    Text(data)
                                }
                            }
                        }
                        .offset(x: -30)
                        .padding(.vertical, 10)
                        .padding(.leading, 10)
                        .padding(.trailing, 30)
                        
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, 0)
                    .frame(maxWidth: .infinity)
                    .background(alignment: .bottom) {
                        Color.orange.opacity(0.3)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 10)

                }
            }
            .padding(.horizontal, 15)
        }
    }
}

#Preview {
    PetProfileView()
}
