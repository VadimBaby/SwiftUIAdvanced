//
//  PropertyWrapperBootcamp.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 21.12.2023.
//

import SwiftUI

extension FileManager {
    static func documnetsPath(key: String) -> URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appending(path: "\(key).txt")
    }
}

@propertyWrapper
struct FileManagerProperty: DynamicProperty {
    @State private var title: String
    let key: String
    
    var wrappedValue: String {
        get {
            title
        }
        nonmutating set {
            save(newValue: newValue)
        }
    }
    
    var projectedValue: Binding<String> {
        Binding {
            return wrappedValue
        } set: { newValue in
            wrappedValue = newValue
        }

    }
    
    init(wrappedValue: String, _ key: String) {
        self.key = key
        do {
            title = try String(contentsOf: FileManager.documnetsPath(key: key), encoding: .utf8)
        } catch {
            //title = "Starting text"
            title = wrappedValue
            print(error.localizedDescription)
        }
    }
    
    func save(newValue: String) {
        do {
            try newValue.write(to: FileManager.documnetsPath(key: key), atomically: false, encoding: .utf8)
            title = newValue
            print("SUCCESS SAVED")
            print(NSHomeDirectory())
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct PropertyWrapperBootcamp: View {
    
    @FileManagerProperty("title1") private var title: String = "Starting text"
    @FileManagerProperty("titl2") private var title2: String = "Start text"
   // var fileManagerProperty = FileManagerProperty()
   // @State private var title: String = "Starting title"
    
    var body: some View {
        VStack(spacing: 40, content: {
            Text(title).font(.largeTitle)
            Text(title2).font(.largeTitle)
            
            PropertyWrapperChildView(title: $title)
            
            Button("Click me 1") {
                title = "title 1"
                title2 = "title 1".uppercased()
            }
            
            Button("Clicm me 2") {
                title = "title 2"
                title = "title 2".uppercased()
            }
        })
    }
}

struct PropertyWrapperChildView: View {
    
    @Binding var title: String
    
    var body: some View {
        Button(action: {
            title = "ANOTHER TITLE!!!"
        }, label: {
            Text(title).font(.largeTitle)
        })
    }
}

#Preview {
    PropertyWrapperBootcamp()
}
