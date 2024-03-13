//
//  ScrollViewOffsetPreferenceKeyBootcamp.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 18.10.2023.
//

import SwiftUI

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {
    func onScrollViewOffsetChanged(action: @escaping (_ value: CGFloat) -> Void) -> some View {
        self
            .background(
                GeometryReader(content: { geo in
                    Text("")
                        .preference(key: ScrollViewOffsetPreferenceKey.self, value: geo.frame(in: .global).minY)
                })
            )
            .onPreferenceChange(ScrollViewOffsetPreferenceKey.self, perform: { value in
                action(value)
            })
    }
}

struct ScrollViewOffsetPreferenceKeyBootcamp: View {
    
    let title: String = "New Title Here"
    
    @State private var scrollViewOffset: CGFloat = .zero
    
    var body: some View {
        ScrollView {
            VStack {
                titleLayer
                    .opacity(Double(scrollViewOffset) / 75)
                    .onScrollViewOffsetChanged { value in
                        self.scrollViewOffset = value
                    }
                
                contentLayer
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .overlay(content: {
            Text("\(scrollViewOffset)")
        })
        .overlay(alignment: .top, content: { navBarLayer
            .opacity(getOpacityForNavBarLayer())
        })
    }
    
    func getOpacityForNavBarLayer() -> Double {
        // 75 - 0
        // 1,5 - 1
        return (-1 * (Double(scrollViewOffset) / 45)) + 1
    }
}

extension ScrollViewOffsetPreferenceKeyBootcamp {
    @ViewBuilder private var titleLayer: some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder private var contentLayer: some View {
        ForEach(0..<30) { _ in
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.orange)
                .frame(width: 300, height: 250)
        }
    }
    
    @ViewBuilder private var navBarLayer: some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(.ultraThinMaterial)
    }
}

#Preview {
    ScrollViewOffsetPreferenceKeyBootcamp()
}
