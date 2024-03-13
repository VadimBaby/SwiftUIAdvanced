//
//  DependencyInjectionBootcamp.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 25.10.2023.
//

import SwiftUI

protocol DataServiceProtocol {
    func getData() async throws -> Data
}

//class Dependencies {
//    let dataService: DataServiceProtocol
//    
//    init(dataService: DataServiceProtocol) {
//        self.dataService = dataService
//    }
//}

class ProductionDataService: DataServiceProtocol {
    
    let urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    func getData() async throws -> Data {
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            return data
        } catch {
            throw error
        }
    }
}

class MockDataService: DataServiceProtocol {
    
    let fakeArray: [PostModel]
    
    init(data: [PostModel]?) {
        self.fakeArray = data ?? [
            PostModel(userId: 1, id: 1, title: "One", body: "one"),
            PostModel(userId: 2, id: 2, title: "Two", body: "two")
        ]
    }
    
    func getData() async throws -> Data {
        let encode = try JSONEncoder().encode(fakeArray)
        return encode
    }
}

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DependencyInjectionViewModel: ObservableObject {
    
    @Published var dataArray: [PostModel] = []
    
    private let dataService: DataServiceProtocol
    
    private var tasks: [Task<Void, Never>] = []
    
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
        
        getReponseFromDatabase()
    }
    
    private func getReponseFromDatabase() {
        let task1 = Task {
            do {
                try await getData()
            } catch {
                print(error.localizedDescription)
            }
        }
        
        tasks.append(task1)
    }
    
    private func getData() async throws {
        guard let data = try? await dataService.getData() else { return }
        
        let dataArray: [PostModel]? = try? JSONDecoder().decode([PostModel].self, from: data)
        
        guard let dataArray else { throw URLError(.badServerResponse) }
        
        await MainActor.run {
            self.dataArray = dataArray
        }
    }
    
    func cancelAllTasks() {
        tasks.forEach{ $0.cancel() }
        tasks = []
    }
}

struct DependencyInjectionBootcamp: View {
    
    @StateObject private var viewModel: DependencyInjectionViewModel
    
    init(dataService: DataServiceProtocol) {
        _viewModel = StateObject(wrappedValue: DependencyInjectionViewModel(dataService: dataService))
    }
    
    var body: some View {
        ScrollView {
            VStack(content: {
                ForEach(viewModel.dataArray) { post in
                    Text(post.title)
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color.gray)
                        .clipShape(.rect(cornerRadius: 15))
                        .padding(.horizontal)
                }
            })
        }
        .onDisappear(perform: {
            viewModel.cancelAllTasks()
        })
    }
}

#Preview {
 //   DependencyInjectionBootcamp(dataService: ProductionDataService(urlString: "https://jsonplaceholder.typicode.com/posts"))
    
    DependencyInjectionBootcamp(dataService: MockDataService(data: nil))
}
