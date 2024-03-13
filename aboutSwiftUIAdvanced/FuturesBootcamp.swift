//
//  FuturesBootcamp.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 17.12.2023.
//

import SwiftUI
import Combine

class FuturesBootcampViewModel: ObservableObject {
    @Published var title: String = "Some title here"
    
    let url = URL(string: "https://www.google.com")!
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        download()
    }
    
    func download() {
//        getCombinePublisher()
//            .sink { _ in
//                
//            } receiveValue: { [weak self] value in
//                self?.title = value
//            }
//            .store(in: &cancellables)

//        getEscapingClosure { [weak self] value, error in
//            self?.title = value
//        }
        
        getFuturePublisher()
            .merge(with: doSomethingInFuture())
            .sink { _ in
                
            } receiveValue: { [weak self] returnedValue in
                self?.title = returnedValue
            }
            .store(in: &cancellables)

    }
    
    func getFuturePublisher() -> Future<String, Error> {
        return Future { promise in
            self.getEscapingClosure { value, error in
                if let error {
                    promise(.failure(error))
                } else {
                    promise(.success(value))
                }
            }
        }
    }
    
    func getCombinePublisher() -> AnyPublisher<String, URLError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .timeout(1, scheduler: DispatchQueue.main)
            .map { _ in
                return "New Value"
            }
            .eraseToAnyPublisher()
    }
    
    func getEscapingClosure(completionHandler: @escaping (_ value: String, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completionHandler("new value 2", nil)
        }
        .resume()
    }
    
    func doSomething(completion: @escaping (_ value: String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
            completion("NEW VALUE")
        })
    }
    
    func doSomethingInFuture() -> Future<String, Error> {
        return Future { promise in
            self.doSomething { value in
                promise(.success(value))
            }
        }
    }
}

struct FuturesBootcamp: View {
    
    @StateObject private var vm = FuturesBootcampViewModel()
    
    var body: some View {
        Text(vm.title)
    }
}

#Preview {
    FuturesBootcamp()
}
