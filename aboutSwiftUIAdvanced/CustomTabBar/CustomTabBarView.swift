//
//  CustomTabBarView.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 19.10.2023.
//

import SwiftUI

struct CustomTabBarView: View {
    
    let tabs: [TabItem]
    
    @Binding var selection: TabItem
    
    @Namespace private var namespace
    
    @State var localSelection: TabItem
    
    var body: some View {
        HStack{
            ForEach(tabs, id: \.self) { tab in
                tabView(tab: tab)
                    .onTapGesture {
                        switchToTab(tab: tab)
                    }
            }
        }
        .padding(6)
        .background(Color.white.ignoresSafeArea(edges: .bottom))
        .clipShape(.rect(cornerRadius: 15))
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0.0, y: 5)
        .padding(.horizontal)
        .padding(.vertical, 1)
        .onChange(of: selection) { _, newValue in
            withAnimation(.easeInOut) {
                localSelection = newValue
            }
        }
    }
}

extension CustomTabBarView {
    private func tabView(tab: TabItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
                .font(.headline)
            Text(tab.title)
                .font(.caption)
        }
        .foregroundStyle(localSelection == tab ? Color.black : Color.gray)
        .padding(.vertical, 6)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                if localSelection == tab {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(tab.color.opacity(0.2))
                        .matchedGeometryEffect(id: "background_selection", in: namespace)
                }
            }
        )
    }
    
    private func switchToTab(tab: TabItem) {
        selection = tab
    }
}

struct TabItem: Hashable {
    let title: String
    let iconName: String
    let color: Color
}

#Preview {
    VStack{
        Spacer()
        CustomTabBarView(tabs: [
            TabItem(title: "Home", iconName: "house", color: Color.green),
            TabItem(title: "Gear", iconName: "gear", color: Color.yellow),
            TabItem(title: "Heart", iconName: "heart.fill", color: Color.red)
        ], selection: .constant(TabItem(title: "Home", iconName: "house", color: Color.green)), localSelection: TabItem(title: "Home", iconName: "house", color: Color.green))
    }
}
