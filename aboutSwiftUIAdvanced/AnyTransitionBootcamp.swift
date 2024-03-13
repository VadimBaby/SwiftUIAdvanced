//
//  AnyTransitionBootcamp.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 15.10.2023.
//

import SwiftUI

struct RotateViewModifier: ViewModifier {
    
    let rotation: Double
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: rotation))
            .offset(
                x: rotation != 0 ? UIScreen.main.bounds.width : 0,
                y: rotation != 0 ? UIScreen.main.bounds.height : 0
            )
    }
}

extension AnyTransition {
    static var rotation: AnyTransition {
        return AnyTransition.modifier(
            active: RotateViewModifier(rotation: 180),
            identity: RotateViewModifier(rotation: 0)
        )
    }
    
    static func rotation(rotating: Double) -> AnyTransition {
        return AnyTransition.modifier(
            active: RotateViewModifier(rotation: rotating),
            identity: RotateViewModifier(rotation: 0)
        )
    }
    
    static var rotationOn: AnyTransition {
        return AnyTransition.asymmetric(
            insertion: .rotation,
            removal: .move(edge: .leading)
        )
    }
    
    static func rotationOn(rotating: Double) -> AnyTransition {
        return AnyTransition.asymmetric(
            insertion: .rotation(rotating: rotating),
            removal: .move(edge: .leading)
        )
    }
}

struct AnyTransitionBootcamp: View {
    
    @State private var showRectangle: Bool = false
    
    var body: some View {
        VStack{
            Spacer()
            
            if showRectangle {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 200, height: 350)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                   // .transition(.rotation)
                   // .transition(.rotation(rotating: 50))
                   // .transition(.rotationOn)
                    .transition(.rotationOn(rotating: 50))
            }
            
            Button(action: {
                withAnimation(.easeInOut) {
                    self.showRectangle.toggle()
                }
            }, label: {
                Text("Show Rectangle")
                    .withDefaultButtonFormatting()
            })
            .padding()
        }
        .padding()
        .ignoresSafeArea()
    }
}

#Preview {
    AnyTransitionBootcamp()
}
