//
//  TabItemView.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 08.12.2023.
//

import SwiftUI

struct TabItemView: View {
    
    let data: TabItemData
    let isSelected: Bool
    
    var body: some View {
        VStack {
            VStack {
                Image(systemName: data.systemImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
                    .foregroundStyle(isSelected ? Color.red : Color.gray)
                
                Text(data.title)
                    .foregroundStyle(isSelected ? Color.red : Color.gray)
            }
        }
    }
}

#Preview {
    TabItemView(
        data: TabItemData(systemImage: "house", title: "Home"),
        isSelected: false
    )
}
