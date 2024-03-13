//
//  FileManagerCodablePropertyWrapper.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 22.12.2023.
//

import SwiftUI

@propertyWrapper
struct FileManagerCodableProperty<T: Codable>: DynamicProperty {
    @State private var value: T?
    let key: String
    
    var wrappedValue: T? {
        get {
            value
        }
        nonmutating set {
            save(newValue: newValue)
        }
    }
    
    var projectedValue: Binding<T?> {
        Binding {
            return wrappedValue
        } set: { newValue in
            wrappedValue = newValue
        }

    }
    
    init(_ key: String) {
        self.key = key
        do {
            let url = FileManager.documnetsPath(key: key)
            
            let data = try Data(contentsOf: url)
            
            let decodeData = try JSONDecoder().decode(T.self, from: data)
            
            _value = State(wrappedValue: decodeData)
        } catch {
            value = nil
            print(error.localizedDescription)
        }
    }
    
    func save(newValue: T?) {
        do {
            let data = try JSONEncoder().encode(newValue)
            try data.write(to: FileManager.documnetsPath(key: key))
            
            value = newValue
            
            print("SUCCESS SAVED")
            print(NSHomeDirectory())
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct User: Codable {
    let name: String
    let age: Int
    let isPremium: Bool
}

struct FileManagerCodablePropertyWrapper: View {
    
    @FileManagerCodableProperty("user") private var userProfile: User?
    
    var body: some View {
        VStack(spacing: 40) {
            if let userProfile {
                Text(userProfile.name)
            }
            
            Button("Change user to matvey") {
                userProfile = User(name: "Matvey", age: 13, isPremium: true)
            }
            
            FileManagerCodablePropertyWrappeChild(userProfile: $userProfile)
        }
    }
}

struct FileManagerCodablePropertyWrappeChild: View {
    
    @Binding var userProfile: User?
    
    var body: some View {
        Button("Change user to vadim") {
            userProfile = User(name: "Vadim", age: 18, isPremium: false)
        }
    }
}

#Preview {
    FileManagerCodablePropertyWrapper()
}
