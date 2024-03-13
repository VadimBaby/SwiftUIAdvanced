//
//  CustomTabBarContainerView.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 19.10.2023.
//

import SwiftUI

struct CustomTabBarContainerView<Content>: View where Content: View {
    
    @Binding var selection: TabItem
    
    let content: Content
    
    @State private var tabs: [TabItem] = []
    
    init(selection: Binding<TabItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .bottom, content: {
            content.ignoresSafeArea()
            
            CustomTabBarView(tabs: tabs, selection: $selection, localSelection: selection)
        })
        .onPreferenceChange(TabBarItemsPreferenceKey.self, perform: { value in
            self.tabs = value
        })
    }
}

#Preview {
    CustomTabBarContainerView(selection: .constant(TabItem(title: "home", iconName: "house", color: Color.green))) {
        Color.red
    }
}
