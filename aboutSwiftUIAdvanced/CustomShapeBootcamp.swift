//
//  CustomShapeBootcamp.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 15.10.2023.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX / 2, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.midX * 1.5, y: rect.minX))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX / 2, y: rect.minY))
        }
    }
}

struct CustomShapeBootcamp: View {
    var body: some View {
        VStack{
            Triangle()
                .fill(Color.blue)
                .frame(width: 250, height: 250)
            
            Spacer()
            
            Diamond()
                .fill(Color.orange)
                .frame(width: 250, height: 250)
        }
    }
}

#Preview {
    CustomShapeBootcamp()
}
