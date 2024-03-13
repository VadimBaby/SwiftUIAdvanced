//
//  AnimateableDataBootcamp.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 17.10.2023.
//

import SwiftUI

struct AnimateableDataBootcamp: View {
    
    @State private var animate: Bool = false
    
    var body: some View {
        ZStack{
          //  RoundedRectangle(cornerRadius: animate ? 60 : 0)
//            RectangleWithSingleArc(cornerRaduis: animate ? 60 : 0)
//                .frame(width: 250, height: 250)
            Packman(offsetAmount: animate ? 20 : 0)
                .frame(width: 250, height: 250)
        }
        .onAppear{
            withAnimation(.linear(duration: 0.3).repeatForever()) {
                animate.toggle()
            }
        }
    }
}

struct RectangleWithSingleArc: Shape {
    var cornerRaduis: CGFloat
    
    var animatableData: CGFloat {
        get {
            return cornerRaduis
        }
        
        set {
            return cornerRaduis = newValue
        }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRaduis))
            path.addArc(
                center: CGPoint(x: rect.maxX - cornerRaduis, y: rect.maxY - cornerRaduis),
             radius: cornerRaduis,
             startAngle: Angle(degrees: 0),
             endAngle: Angle(degrees: 360),
             clockwise: false
            )
            path.addLine(to: CGPoint(x: rect.maxX - cornerRaduis, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: .zero)
        }
    }
}

struct Packman: Shape {
    
    var offsetAmount: Double
    
    var animatableData: Double {
        get {
            return offsetAmount
        }
        
        set {
            return offsetAmount = newValue
        }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.height / 2,
                startAngle: Angle(degrees: offsetAmount),
                endAngle: Angle(degrees: 360 - offsetAmount),
                clockwise: false)
        }
    }
}

#Preview {
    AnimateableDataBootcamp()
}
