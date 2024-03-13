//
//  AppNavBarView.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 20.10.2023.
//

import SwiftUI

struct AppNavBarView: View {
    var body: some View {
        CustomNavView {
            ZStack {
                Color.orange.ignoresSafeArea()
                
                CustomNavLink(destination: SecondScreen()) {
                    Text("CLICK ME")
                }
            }
            .customNavigationTitle("HI BRO")
        }
    }
}

struct SecondScreen: View {
    var body: some View {
        Text("Second Screen")
            .customNavBarItems(title: "Second", subtitle: "they all props", hidden: false)
    }
}

#Preview {
    AppNavBarView()
}
