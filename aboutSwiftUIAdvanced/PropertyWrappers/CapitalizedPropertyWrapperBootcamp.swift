//
//  CapitalizedPropertyWrapperBootcamp.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 22.12.2023.
//

import SwiftUI

@propertyWrapper
struct Capitalized: DynamicProperty {
    @State private var text: String
    
    var wrappedValue: String {
        get {
            return text
        }
        nonmutating set {
            text = newValue.capitalized
        }
    }
    
    init(wrappedValue: String) {
        self.text = wrappedValue.capitalized
    }
}

struct CapitalizedPropertyWrapperBootcamp: View {
    
    @State private var textFieldText: String = ""
    @Capitalized private var text: String = "first text"
    
    var body: some View {
        VStack {
            Text(text)
            TextField("text", text: $textFieldText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocorrectionDisabled()
            Button("Set") {
                self.text = textFieldText
            }
        }
    }
}

#Preview {
    CapitalizedPropertyWrapperBootcamp()
}
