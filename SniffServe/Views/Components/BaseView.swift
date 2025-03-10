//
//  BaseView.swift
//  SniffServe
//
//  Created by Sebastian on 2/11/25.
//


import SwiftUI

struct BaseView<Content: View, TopRightView: View>: View {
    // Create the template/basis for all the screen of the app
    // Can be used to determine icons (top left, top right, bottom left, bottom right) and their actions for each screen
    
    var screenTitle: String?
    let content: () -> Content
    
    let topLeftIcon: String?
    let topLeftAction: () -> Void
    let topRightIcon: String?
    let topRightAction: () -> Void
    @ViewBuilder let topRightView: TopRightView
    
    let botLeftIcon: String?
    let botLeftAction: () -> Void
    let botRightIcon: String?
    let botRightAction: () -> Void
    
    
    // Parameters that can be passed to View. Names of icons and associated
    // actions can be passed as well as the title of the screen and the view to
    // to be shown within the base view
    
    init(
        screenTitle: String? = nil,
        topLeftIcon: String? = nil,
        topLeftAction: @escaping () -> Void = {},
        topRightIcon: String? = nil,
        topRightAction: @escaping () -> Void = {},
        topRightView: TopRightView = EmptyView(),
        botLeftIcon: String? = nil,
        botLeftAction: @escaping () -> Void = {},
        botRightIcon: String? = nil,
        botRightAction: @escaping () -> Void = {},
        @ViewBuilder content: @escaping () -> Content
    ){
        self.screenTitle = screenTitle
        self.content = content
        
        self.topLeftIcon = topLeftIcon
        self.topLeftAction = topLeftAction
        self.topRightIcon = topRightIcon
        self.topRightAction = topRightAction
        self.topRightView = topRightView
        
        self.botLeftIcon = botLeftIcon
        self.botLeftAction = botLeftAction
        self.botRightIcon = botRightIcon
        self.botRightAction = botRightAction
    }
    
    @State private var showView = false
    
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                    content()
                }
            }
            // Green bar area at the top
            .safeAreaInset(edge: .top, spacing: 0) {
                HStack {
                    // Left button
                    if let topLeftIcon = topLeftIcon {
                        Button {
                            topLeftAction()
                        } label: {
                            Image(systemName: topLeftIcon)
                                .foregroundColor(.black)
                                .font(.largeTitle)
                        }
                        .padding(.leading, 5.0)
                    } else {
                        Spacer()
                    }
                    
                    // Title name
                    Text(screenTitle ?? "")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .lineLimit(1)
                    
                    // Right button
                    if let topRightIcon = topRightIcon {
                        Button {
                            topRightAction()
                            showView.toggle()
                        } label: {
                            Image(systemName: topRightIcon)
                                .foregroundColor(.black)
                                .font(.largeTitle)
                        }
                        .padding(.leading, 5.0)
                    } else {
                        Spacer()
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 70)
                .background(.green)
                .navigationDestination(isPresented: $showView) {
                    topRightView
                }
            }
            
            // Green bar area at the bottom
            .safeAreaInset(edge: .bottom, spacing: 0) {
                HStack(spacing: 120) {
                    
                    if botLeftIcon != nil {
                        Button {
                            botLeftAction()
                        } label: {
                            Image(systemName: botLeftIcon ?? "")
                                .foregroundColor(.black)
                                .font(.system(size: 45))
                        }
                        .padding(.top, 25.0)
                    }
                    
                    if botRightIcon != nil {
                        Button {
                            botRightAction()
                        } label: {
                            Image(systemName: botRightIcon ?? "")
                                .foregroundColor(.black)
                                .font(.system(size: 45))
                        }
                        .padding(.top, 35.0)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 70)
                .background(.green)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView() {
        }
    }
}



