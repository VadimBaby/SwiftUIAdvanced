//
//  ColorPropertyWrapperBootcamp.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 21.12.2023.
//

import SwiftUI

extension Color {
    var cgColor_: CGColor {
        UIColor(self).cgColor
    }
}

extension UserDefaults {
    func setColor(_ color: Color, forKey key: String) {
        let cgColor = color.cgColor_
        let array = cgColor.components ?? []
        set(array, forKey: key)
    }

    func color(forKey key: String) -> Color? {
        guard let array = object(forKey: key) as? [CGFloat] else { return nil }
        let color = CGColor(colorSpace: CGColorSpace(name: CGColorSpace.sRGB)!, components: array)!
        return Color(color)
    }
}

@propertyWrapper
struct ColorAppStorage: DynamicProperty {
    @State var color: Color
    
    private let key: String
    
    var wrappedValue: Color {
        get {
            return color
        }
        nonmutating set {
            update(color: newValue)
        }
    }
    
    var projectedValue: Binding<Color> {
        Binding {
            color
        } set: { newValue in
            update(color: newValue)
        }

    }
    
    init(wrappedValue: Color, _ key: String) {
        self.key = key
        if let savedColor = UserDefaults.standard.color(forKey: key) {
            self.color = savedColor
        } else {
            self.color = wrappedValue
        }
    }
    
    private func update(color: Color) {
        UserDefaults.standard.setColor(color, forKey: key)
        
        self.color = color
    }
}

struct ColorPropertyWrapperBootcamp: View {
    
    @ColorAppStorage("secondColor") var color: Color = Color.red
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(color)
                .frame(width: 150, height: 150)
            
            Button("black") {
                color = Color.black
            }
            
            Button("purple") {
                color = Color.purple
            }
            
            ColorPropertyWrapperBootcampChild(color: $color)
        }
        
    }
}

struct ColorPropertyWrapperBootcampChild: View {
    
    @Binding var color: Color
    
    var body: some View {
        Button("Change to green") {
            color = Color.green
        }
        .background(color)
    }
}

#Preview {
    ColorPropertyWrapperBootcamp()
}
