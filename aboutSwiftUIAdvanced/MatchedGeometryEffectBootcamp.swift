//
//  MatchedGeometryEffectBootcamp.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 15.10.2023.
//

import SwiftUI

struct MatchedGeometryEffectBootcamp: View {
    
    @State private var isClicked: Bool = false
    @Namespace private var namespace
    
    var body: some View {
        VStack{
            if !isClicked {
                RoundedRectangle(cornerRadius: 15)
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 100, height: 100)
            }
            
            Spacer()
            
            if isClicked {
                RoundedRectangle(cornerRadius: 15)
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 300, height: 100)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.red)
        .onTapGesture {
            withAnimation(.easeInOut) {
                isClicked.toggle()
            }
        }
    }
}

#Preview {
    MatchedGeometryEffectExample2()
}

struct MatchedGeometryEffectExample2: View {
    
    let categories = ["Home", "Popular", "Saved"]
    
    @State private var selected = "Home"
    @Namespace private var namespace2
    
    var body: some View {
        HStack{
            ForEach(categories, id: \.self) { category in
                ZStack{
                    if selected == category {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.red.opacity(0.7))
                            .matchedGeometryEffect(id: "background", in: namespace2)
                    }
                    
                    Text(category)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .onTapGesture {
                    withAnimation(.spring()) {
                        selected = category
                    }
                }
            }
        }
        .padding()
    }
}
