//
//  GeometryPreferenceKeyBootcamp.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 18.10.2023.
//

import SwiftUI

struct GeometryPreferenceKeyBootcamp: View {
    
    @State private var sizeText: CGSize = .zero
    
    var body: some View {
        VStack{
            Text("Hello Word")
                .frame(width: sizeText.width, height: sizeText.height)
                .background(Color.blue)
            
            Spacer()
            
            HStack{
                Rectangle()
                
                GeometryReader(content: { geometry in
                    Rectangle()
                        .setTextSize(geometry.size)
                })
                
                Rectangle()
            }
            .frame(height: 55)
        }
        .padding(.vertical)
        .onPreferenceChange(RectangleGeometryPreferenceKey.self, perform: { value in
            self.sizeText = value
        })
    }
}

extension View {
    func setTextSize(_ size: CGSize) -> some View {
        self
            .preference(key: RectangleGeometryPreferenceKey.self, value: size)
    }
}

struct RectangleGeometryPreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

#Preview {
    GeometryPreferenceKeyBootcamp()
}
