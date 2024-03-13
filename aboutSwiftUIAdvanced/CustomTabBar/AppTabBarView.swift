//
//  AppTabBarView.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 19.10.2023.
//

import SwiftUI

struct AppTabBarView: View {
    
    @State private var selection: TabItem = TabItem(title: "Home", iconName: "house", color: Color.green)
    
    var body: some View {
        CustomTabBarContainerView(selection: $selection) {
            Color.green
                .tabBarItem(tab: TabItem(title: "Home", iconName: "house", color: Color.green), selection: $selection)
            
            Color.red
                .tabBarItem(tab: TabItem(title: "Heart", iconName: "heart.fill", color: Color.red), selection: $selection)
            
            Color.blue
                .tabBarItem(tab: TabItem(title: "Settings", iconName: "gear", color: Color.blue), selection: $selection)
        }
    }
}

#Preview {
    AppTabBarView()
}
