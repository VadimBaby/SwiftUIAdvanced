//
//  CustomNavBarContainerView.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 20.10.2023.
//

import SwiftUI

struct CustomNavBarContainerView<Content: View>: View {
    
    @State private var title: String = ""
    @State private var subtitle: String? = nil
    @State private var showBackButton: Bool = true
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0, content: {
            CustomNavBarView(
                showBackButton: showBackButton,
                title: title,
                subtitle: subtitle
            )
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        })
        .onPreferenceChange(CustomNavBarTitlePreferenceKey.self, perform: { value in
            self.title = value
        })
        .onPreferenceChange(CustomNavBarSubtitlePreferenceKey.self, perform: { value in
            self.subtitle = value
        })
        .onPreferenceChange(CustomNavBarBackButtonHiddenPreferenceKey.self, perform: { value in
            self.showBackButton = !value
        })
    }
}

#Preview {
    CustomNavBarContainerView {
        ZStack{
            Color.green.ignoresSafeArea()
            
            Text("Hello")
                .foregroundStyle(Color.white)
        }
        .customNavBarItems(title: "HI", subtitle: "Im here", hidden: false)
    }
}
