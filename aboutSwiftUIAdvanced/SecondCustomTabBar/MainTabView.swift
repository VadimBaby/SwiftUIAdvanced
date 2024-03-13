//
//  MainTabView.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 08.12.2023.
//

import SwiftUI

struct MainTabView: View {
    @State var selectedIndex: Int = 0
        
    var body: some View {
        CustomTabView(tabs: TabType.allCases.map({ $0.tabItem }), selectedIndex: $selectedIndex) { index in
            let type = TabType(rawValue: index) ?? .home
            getTabView(type: type)
        }
    }
    
    @ViewBuilder
    func getTabView(type: TabType) -> some View {
        switch type {
        case .home:
            Text("Home")
        case .profile:
            Text("Profile")
        case .settings:
            Text("Settings")
        }
    }
}

#Preview {
    MainTabView()
}
