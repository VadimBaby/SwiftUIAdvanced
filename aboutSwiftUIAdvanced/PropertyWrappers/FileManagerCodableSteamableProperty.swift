//
//  FileManagerCodableSteamableProperty.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 22.12.2023.
//

import SwiftUI
import Combine

@propertyWrapper
struct FileManagerCodableStreamableProperty<T: Codable>: DynamicProperty {
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
    
    var projectedValue: CurrentValueSubject<T?, Never> {
        publisher
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


struct FileManagerCodableSteamableProperty: View {
    
    @FileManagerCodableStreamableProperty("user") private var userProfile: User?
    
    var body: some View {
        VStack {
            if let userProfile {
                Text(userProfile.name)
            }
            
            Button("Changed") {
                userProfile = User(name: "123", age: 123, isPremium: false)
            }
        }
        .onReceive($userProfile, perform: { newValue in
            print("Reveive, new value: \(newValue)")
        })
    }
}

#Preview {
    FileManagerCodableSteamableProperty()
}
