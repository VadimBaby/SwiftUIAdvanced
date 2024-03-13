//
//  TabItemData.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 08.12.2023.
//

import Foundation

struct TabItemData {
    let systemImage: String
    let title: String
}

enum TabType: Int, CaseIterable {
    case home = 0
    case profile = 1
    case settings = 2
    
    var tabItem: TabItemData {
        switch self {
        case .home:
            return TabItemData(systemImage: "house", title: "Home")
        case .profile:
            return TabItemData(systemImage: "person", title: "Profile")
        case .settings:
            return TabItemData(systemImage: "gear", title: "Settings")
        }
    }
}
