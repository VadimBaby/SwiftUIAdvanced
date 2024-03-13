//
//  GenericTypeBootcamp.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 17.10.2023.
//

import SwiftUI

struct StringModel {
    let info: String?
    
    func removeInfo() -> StringModel {
        return StringModel(info: nil)
    }
}

struct BoolModel {
    let info: Bool?
    
    func removeInfo() -> BoolModel {
        return BoolModel(info: nil)
    }
}

struct GenericModel<T> {
    let info: T?
    
    func removeInfo() -> GenericModel {
        return GenericModel(info: nil)
    }
}

struct IdentifiableModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}

struct AnotherGenericModel<T: Identifiable> {
    let model: T
}

class GenericTypeBootcampViewModel: ObservableObject {
    @Published private(set) var stringModel = StringModel(info: "Hello")
    @Published private(set) var boolModel = BoolModel(info: true)
    
    @Published private(set) var genericString = GenericModel(info: "Generic String")
    @Published private(set) var genericBool = GenericModel(info: false)
    
    @Published private(set) var model = AnotherGenericModel(model: IdentifiableModel(title: "Hi"))
    
    func deleteInfo() {
        stringModel = stringModel.removeInfo()
        boolModel = boolModel.removeInfo()
        
        genericString = genericString.removeInfo()
        genericBool = genericBool.removeInfo()
    }
}

struct GenericView<T: View>: View { // <T: View> it means that any type should be conform to View (insted of view can be any protocol)
    
    let title: String
    let content: T
    
    var body: some View {
        HStack{
            Text(title)
            content
        }
    }
}

struct GenericTypeBootcamp: View {
    
    @StateObject private var viewModel = GenericTypeBootcampViewModel()
    
    var body: some View {
        VStack{
            GenericView(title: "Drive Me Crazy", content: Text("😘"))
            
            Text(viewModel.stringModel.info ?? "no data")
            Text(viewModel.boolModel.info?.description ?? "no data")
            
            Text(viewModel.genericString.info ?? "no data")
            Text(viewModel.genericBool.info?.description ?? "no data")
        }
            .onTapGesture {
                viewModel.deleteInfo()
            }
    }
}

#Preview {
    GenericTypeBootcamp()
}
