//
//  TabBottomView.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 08.12.2023.
//

import SwiftUI

struct TabBottomView: View {
    
    let tabBarItems: [TabItemData]
    let height: CGFloat = 70
    @Binding var selectedIndex: Int
    
    var body: some View {
        GeometryReader(content: { geometry in
            HStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    ForEach(tabBarItems.indices) { index in
                        let item = tabBarItems[index]
                        
                        TabItemView(data: item, isSelected: selectedIndex == index)
                            .onTapGesture {
                                self.selectedIndex = index
                            }
                        
                        Spacer()
                    }
                }
                .frame(width: geometry.size.width - 32, height: height)
                .background(Color.white)
                .clipShape(.rect(cornerRadius: 15))
                .shadow(radius: 5, x: 0, y: 4)
                
                Spacer()
            }
        })
        .frame(height: height)
    }
}

#Preview {
    TabBottomView(
        tabBarItems: TabType.allCases.map{ $0.tabItem },
        selectedIndex: .constant(0)
    )
}
