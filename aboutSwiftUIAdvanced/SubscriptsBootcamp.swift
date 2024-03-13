//
//  SubscriptsBootcamp.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 24.12.2023.
//

import SwiftUI

extension Array {
    func getItem(atIndex: Int) -> Element? {
        for (index, element) in self.enumerated() {
            if index == atIndex {
                return element
            }
        }
        
        return nil
    }
}

extension Array where Element == String {
    
    subscript(value: String) -> Element? {
        return self.first(where: { $0 == value })
    }
}

struct Address {
    let street: String
    let city: City
}

struct City {
    let name: String
    let state: String
}

struct Customer {
    let name: String
    let address: Address
    
    subscript(value: String) -> String? {
        switch value {
        case "name":
            return name
        case "address":
            return "street: \(address.street), \(address.city.name)"
        case "city":
            return address.city.name
        default:
            return nil
        }
    }
}

struct SubscriptsBootcamp: View {
    
    @State private var myArray: [String] = ["one", "two", "three"]
    @State private var selectedItem: String? = nil
    
    var body: some View {
        VStack {
            ForEach(myArray, id: \.self) { string in
                Text(string)
            }
            
            Text("SELECTED: \(selectedItem ?? "none")")
        }
        .onAppear {
           // selectedItem = myArray[0]
            self.selectedItem = myArray.getItem(atIndex: 0)
            self.selectedItem = myArray["two"]
            
            let customer = Customer(name: "Vadim", address: Address(street: "Marks", city: City(name: "Nobosibirsk", state: "Texac")))
            
            self.selectedItem = customer["address"]
        }
    }
}

#Preview {
    SubscriptsBootcamp()
}
