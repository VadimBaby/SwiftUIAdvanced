//
//  KeyPathsBootcamp.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 20.12.2023.
//

import SwiftUI

extension Array {
    func sortedByKeyPath<T: Comparable>(_ keyPath: KeyPath<Element, T>, ascending: Bool = true) -> [Element] {
        self.sorted { item1, item2 in
            
            let value1 = item1[keyPath: keyPath]
            let value2 = item2[keyPath: keyPath]
            
            return ascending ? (value1 < value2) : (value1 > value2)
        }
    }
}

struct MyDataModel: Identifiable {
    let id: String = UUID().uuidString
    let title: String
    let count: Int
    let date: Date
}

struct KeyPathsBootcamp: View {
    
    @State private var dataArray: [MyDataModel] = [
        MyDataModel(title: "home", count: 2, date: .distantFuture),
        MyDataModel(title: "away", count: 3, date: .now),
        MyDataModel(title: "get", count: 1, date: .distantPast)
    ]
    
    var body: some View {
        List {
            ForEach(dataArray) { item in
                VStack {
                    Text(item.id)
                    Text(item.title)
                    Text("\(item.count)")
                    Text(item.date.description)
                }
            }
        }
        .onAppear {
            // let newArray = dataArray.sorted(by: {$0.count > $1.count})
            
            let newArray = dataArray.sortedByKeyPath(\.id, ascending: false)
            
            dataArray = newArray
        }
    }
}

#Preview {
    KeyPathsBootcamp()
}
