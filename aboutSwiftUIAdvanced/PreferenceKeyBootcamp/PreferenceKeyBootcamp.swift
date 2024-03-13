//
//  PreferenceKeyBootcamp.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 18.10.2023.
//

import SwiftUI

struct PreferenceKeyBootcamp: View {
    
    @State private var text: String = ""
    
    var body: some View {
        VStack{
            Text(text)
            
            ChildView()
        }
        .onPreferenceChange(CustomTitlePreferenceKey.self, perform: { value in
            self.text = value
        })
    }
}

extension View {
    func customTitle(_ text: String) -> some View {
        self
            .preference(key: CustomTitlePreferenceKey.self, value: text)
    }
}

struct ChildView: View {
    
    @State private var dataString: String = ""
    
    var body: some View {
        Text("Child View")
            .customTitle(dataString)
            .onAppear(perform: getDataFromDataBase)
    }
    
    func getDataFromDataBase() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.dataString = "DATA FROM DATABASE!!!"
        }
    }
}

struct CustomTitlePreferenceKey: PreferenceKey {
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

#Preview {
    PreferenceKeyBootcamp()
}
