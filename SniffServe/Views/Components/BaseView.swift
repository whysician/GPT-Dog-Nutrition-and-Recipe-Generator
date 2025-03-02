//
//  BaseView.swift
//  SniffServe
//
//  Created by Sebastian on 2/11/25.
//


import SwiftUI

struct BaseView<Content: View, TopRightView: View>: View {
    let screenTitle: String?
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
            // Create green sections at top and bottom of screen for the
            // placement of icons and titles
            .safeAreaInset(edge: .top, spacing: 0) {
                HStack {
                    Button {
                        topLeftAction()
                    } label: {
                        Image(systemName: topLeftIcon ?? "")
                            .foregroundColor(.black)
                            .font(.largeTitle)
                    }
                    .padding(.leading, 5.0)
                    
                    
                    Spacer()
                    Text(screenTitle ?? "")
                        .font(.title)
                    
                    Spacer()
                    
                    Button {
                        showView.toggle()
                    } label: {
                        Image(systemName: topRightIcon ?? "")
                            .foregroundColor(.black)
                            .font(.largeTitle)
                    }
                    .padding(.leading, 5.0)

                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 70)
                .background(.green)
                .navigationDestination(isPresented: $showView) {
                    topRightView
                }
            }
            
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
                .frame(maxWidth: .infinity, maxHeight: 70
                )
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



