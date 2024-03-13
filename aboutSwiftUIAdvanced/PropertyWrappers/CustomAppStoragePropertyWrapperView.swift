//
//  CustomAppStoragePropertyWrapperView.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 23.12.2023.
//

import SwiftUI

@propertyWrapper
struct CustomUserDefault<T: Any>: DynamicProperty {
    @State private var user: T
    
    private let key: String
    
    var wrappedValue: T {
        get {
            user
        }
        nonmutating set {
            save(newValue: newValue)
        }
    }
    
    var projectedValue: Binding<T> {
        Binding {
            user
        } set: { newValue in
            save(newValue: newValue)
        }

    }
    
    init(wrappedValue: T, _ key: String) {
        self.key = key
        
        guard let oldValue = UserDefaults.standard.value(forKey: key),
              let oldValueT = oldValue as? T else {
                  self._user = State(wrappedValue: wrappedValue)
            return
        }
        
        self._user = State(wrappedValue: oldValueT)
    }
    
    private func save(newValue: T) {
        UserDefaults.standard.setValue(newValue, forKey: key)
        user = newValue
    }
}

struct CustomAppStoragePropertyWrapperView: View {
    
    @CustomUserDefault("key") private var user: String = "Lets go"
    
    var body: some View {
        VStack {
            Text(user)
            
            Button("set as vadim") {
                user = "vadim"
            }
            
            Button("set as matvey") {
                user = "matvey"
            }
            
            CustomAppStoragePropertyWrapperViewItem(user: $user)
        }
        .sheet(isPresented: Binding(get: {
            return user == "vadim"
        }, set: { newValue in
            user = newValue ? "vadim" : "close"
        }), content: {
            Text("some Text")
        })
    }
}

struct CustomAppStoragePropertyWrapperViewItem: View {
    
    @Binding var user: String
    
    init(user: Binding<String>) {
        self._user = user
    }
    
    var body: some View {
        Text(user)
            .onTapGesture {
                user = "chicken"
            }
    }
}
#Preview {
    CustomAppStoragePropertyWrapperView()
}
