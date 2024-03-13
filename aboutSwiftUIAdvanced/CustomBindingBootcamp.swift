//
//  CustomBindingBootcamp.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 17.12.2023.
//

import SwiftUI

extension Binding where Value == Bool {
    init(value: Binding<String?>) {
        self.init {
            return value.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        }

    }
}

struct CustomBindingBootcamp: View {
    
    @State private var title: String = "some title"
    
    @State private var error: String? = nil
    
    var body: some View {
        VStack {
            Text(title)
            
            ChildCustomBindingView1(title: $title)
            ChildCustomBindingView2(title: $title)
            ChildCustomBindingView3(title: Binding(get: {
                return title
            }, set: { newValue in
                title = newValue
            }))
            
            Button("Show Error") {
                error = "NEW ERROR"
            }
            .buttonStyle(BorderedProminentButtonStyle())
        }
        .alert(error ?? "Error", isPresented: Binding(value: $error)) {
            Button("OK") {
                
            }
        }
//        .alert(error ?? "Error", isPresented: Binding(get: {
//            return error != nil
//        }, set: { newValue in
//            if !newValue {
//                error = nil
//            }
//        })) {
//            Button("OK") {
//                
//            }
//        }
    }
}

struct ChildCustomBindingView1: View {
    
    @Binding var title: String
    
    var body: some View {
        Text(title)
    }
}

struct ChildCustomBindingView2: View {
    
    var title: Binding<String>
    
    var body: some View {
        Text(title.wrappedValue)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                    title.wrappedValue = "NEW TITLE"
                })
            }
    }
}

struct ChildCustomBindingView3: View {
    
    @Binding var title: String
    
    var body: some View {
        Text(title)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
                    title = "NEW TITLE!!!"
                })
            }
    }
}

#Preview {
    CustomBindingBootcamp()
}
