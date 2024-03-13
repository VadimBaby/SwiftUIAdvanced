//
//  ButtonStyleBootcamp.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 15.10.2023.
//

import SwiftUI

struct ButtonPressableStyle: ButtonStyle {
    let scaleAmount: CGFloat
    
    init(scaleAmount: CGFloat = 0.9) {
        self.scaleAmount = scaleAmount
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaleAmount : 1.0)
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

extension View {
    func withButtonPressableStyle(_ scaleAmount: CGFloat = 0.9) -> some View {
        self.buttonStyle(ButtonPressableStyle(scaleAmount: scaleAmount))
    }
}

struct ButtonStyleBootcamp: View {
    var body: some View {
        VStack(spacing: 25){
            Button(action: {}, label: {
                Text("Button")
                    .withDefaultButtonFormatting()
            })
            .buttonStyle(ButtonPressableStyle(scaleAmount: 0.8))
            
            Button(action: {}, label: {
                Text("Second Button")
                    .withDefaultButtonFormatting()
            })
            .buttonStyle(ButtonPressableStyle())
            
            Button(action: {}, label: {
                Text("Third Button")
                    .withDefaultButtonFormatting()
            })
            .withButtonPressableStyle()
            
            Button(action: {}, label: {
                Text("Four Button")
                    .withDefaultButtonFormatting()
            })
            .withButtonPressableStyle(0.7)
        }
        .padding(40)
    }
}

#Preview {
    ButtonStyleBootcamp()
}
