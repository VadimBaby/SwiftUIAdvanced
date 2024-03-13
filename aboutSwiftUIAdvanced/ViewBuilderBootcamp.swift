//
//  ViewBuilderBootcamp.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 17.10.2023.
//

import SwiftUI

struct HeaderViewRegular: View {
    
    let title: String
    let description: String?
    let icon: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            if let description {
                Text(description)
                    .font(.callout)
            }
            
            if let icon {
                Image(systemName: icon)
            }
            
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct HeaderViewGeneric<Content: View>: View {
    
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            content
            
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct CustomHStack<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        HStack(spacing: 30) {
            content
        }
    }
}

struct ViewBuilderBootcamp: View {
    var body: some View {
        VStack{
            HeaderViewRegular(title: "Hello", description: "World", icon: "heart.fill")
            
            HeaderViewRegular(title: "Hi", description: nil, icon: "gear")
            
            HeaderViewRegular(title: "Damn", description: nil, icon: nil)
            
            HeaderViewGeneric(title: "Generic Title") {
                HStack {
                    Text("Generic Description")
                    Image(systemName: "heart.fill")
                }
            }
            
            HStack{
                Text("One")
                Text("Two")
            }
            
            CustomHStack {
                Text("One")
                Text("Two")
            }
            
            CustomHStack {
                getSomeView()
            }
            
            CustomHStack {
                viewOne
            }
            
            Spacer()
        }
    }
    
    @ViewBuilder private func getSomeView() -> some View {
        Text("1")
        Text("2")
    }
    
    @ViewBuilder private var viewOne: some View {
        Text("One!!!")
        Text("Two!!!")
    }
}

#Preview {
    ViewBuilderBootcamp()
}
