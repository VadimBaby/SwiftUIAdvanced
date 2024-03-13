//
//  CustomNavBarView.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 20.10.2023.
//

import SwiftUI

struct CustomNavBarView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let showBackButton: Bool
    let title: String
    let subtitle: String?
    
    var body: some View {
        HStack {
            if showBackButton {
                backButton
            }
            Spacer()
            titleSection
            Spacer()
            if showBackButton {
                backButton
                    .opacity(0)
            }
        }
        .padding()
        .tint(Color.white)
        .foregroundStyle(Color.white)
        .font(.headline)
        .background(
            Color.blue.ignoresSafeArea()
        )
    }
}

extension CustomNavBarView {
    private var backButton: some View {
        Button(action: {
            dismiss()
        }, label: {
            Image(systemName: "chevron.left")
        })
    }
    
    private var titleSection: some View {
        VStack(spacing: 4, content: {
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
            if let subtitle = subtitle {
                Text(subtitle)
            }
        })
    }
}

#Preview {
    VStack{
        CustomNavBarView(showBackButton: true, title: "Title", subtitle: "Subtitle")
        Spacer()
    }
}
