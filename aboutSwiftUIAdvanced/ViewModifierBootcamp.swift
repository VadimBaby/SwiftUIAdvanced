//
//  ViewModifierBootcamp.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 15.10.2023.
//

import SwiftUI

struct DefaultButtonViewModifier: ViewModifier {
    
    let backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundStyle(Color.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .clipShape(.rect(cornerRadius: 15))
            .shadow(radius: 15)
    }
}

extension View {
    func withDefaultButtonFormatting(_ backgroundColor: Color = Color.blue) -> some View {
        self
            .modifier(DefaultButtonViewModifier(backgroundColor: backgroundColor))
    }
}

struct ViewModifierBootcamp: View {
    var body: some View {
        VStack(spacing: 20){
            Text("Hello, World!")
                .withDefaultButtonFormatting()
            
            Text("Hi")
                .modifier(DefaultButtonViewModifier(backgroundColor: Color.orange))
            
            Text("Damn")
                .withDefaultButtonFormatting(Color.red)
        }
        .padding()
    }
}

#Preview {
    ViewModifierBootcamp()
}
