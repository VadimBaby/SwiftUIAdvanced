//
//  FileManagerCodableMasterProperty.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 22.12.2023.
//

import SwiftUI

import Combine

@propertyWrapper
struct FileManagerCodableMasterProperty<T: Codable>: DynamicProperty {
    @State private var value: T?
    let key: String
    private let publisher: CurrentValueSubject<T?, Never>
    
    var wrappedValue: T? {
        get {
            value
        }
        nonmutating set {
            save(newValue: newValue)
        }
    }
    
    var projectedValue: CustomProjectedValue<T> {
        CustomProjectedValue(
            binding: Binding(get: {
                return wrappedValue
            }, set: { newValue in
                wrappedValue = newValue
            }),
            publisher: publisher
        )
    }
    
    init(_ key: String) {
        self.key = key
        do {
            let url = FileManager.documnetsPath(key: key)
            
            let data = try Data(contentsOf: url)
            
            let decodeData = try JSONDecoder().decode(T.self, from: data)
            
            _value = State(wrappedValue: decodeData)
            publisher = CurrentValueSubject(decodeData)
        } catch {
            _value = State(wrappedValue: nil)
            publisher = CurrentValueSubject(nil)
            print(error.localizedDescription)
        }
    }
    
    private func save(newValue: T?) {
        do {
            let data = try JSONEncoder().encode(newValue)
            try data.write(to: FileManager.documnetsPath(key: key))
            
            value = newValue
            publisher.send(newValue)
            
            print("SUCCESS SAVED")
            print(NSHomeDirectory())
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct CustomProjectedValue<T: Codable> {
    let binding: Binding<T?>
    let publisher: CurrentValueSubject<T?, Never>
    
    var steam: AsyncPublisher<CurrentValueSubject<T?, Never>> {
        publisher.values
    }
}

struct FileManagerCodableMasterPropertyWrapper: View {
    
    @FileManagerCodableMasterProperty("user") private var user: User?
    
    var body: some View {
        VStack(spacing: 25) {
            if let user {
                Text(user.name)
            }
            
            Button("Chane") {
                user = User(name: "asdasd", age: 1243124, isPremium: false)
            }
            
            FileManagerCodableMasterPropertyWrapperChild(user: $user.binding)
        }
        .onReceive($user.publisher, perform: { newValue in
            print("receive: \(newValue)")
        })
        .task {
            for await value in $user.steam {
                print("task: \(value)")
            }
        }
    }
}

struct FileManagerCodableMasterPropertyWrapperChild: View {
    
    @Binding var user: User?
    
    var body: some View {
        Button("Chane another") {
            user = User(name: "kukak", age: 11, isPremium: true)
        }
    }
}

#Preview {
    FileManagerCodableMasterPropertyWrapper()
}
