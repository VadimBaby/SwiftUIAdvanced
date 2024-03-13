//
//  AdvancedCombineBootcamp.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 16.12.2023.
//

import SwiftUI
import Combine

class AdvancedCombineDataService {
    @Published var basicPublisher: Int = 0
    
    // its the same thing like basicPublisher
    let currentBasicPublisher = CurrentValueSubject<Int, Error>(0)
    
    // its the same thing but withiut initial value
    let passthoughtPublisher = PassthroughSubject<Int, Error>()
    
    init() {
        publishFakeData()
    }
    
    private func publishFakeData() {
        let items: [Int] = Array(0..<11)
        
        for x in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(x), execute: {
                self.passthoughtPublisher.send(items[x])
               // self.currentBasicPublisher.send(items[x])
                //  self.basicPublisher = items[x]
                
                
                // finish publisher
                if x == items.indices.last {
                    self.passthoughtPublisher.send(completion: .finished)
                }
            })
        }
    }
}

class AdvancedCombineViewModel: ObservableObject {
    @Published var data: [String] = []
    @Published var error: String = ""
    
    let service = AdvancedCombineDataService()
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubcriber()
    }
    
    func addSubcriber() {
        service.passthoughtPublisher
        
            // Sequence Operations
        /*
//            .first() // Publishes the first element of a stream, then finishes.
        
 //           .first(where: {$0 > 4}) // return only 5
        
//            .tryFirst(where: { value in
//                if value == 3 {
//                    throw URLError(.badServerResponse) // that error will go to self.error
//                }
//                
//                return value > 4
//            })
        
//            .last() // Publishes the last element of a stream, then finishes.
        
//            .last(where: {$0 < 6}) // its going be 5, it shows value when publisher is ended
        
//            .tryLast(where: { value in
//                if value == 3 {
//                    throw URLError(.badServerResponse)
//                }
//                
//                return value > 1
//            })
        
//            .dropFirst() // it doesnt show first element
        
//            .dropFirst(3) // it doesnt show первые три elements
        
//            .drop(while: { value in // we will drop elements while these elements < 4
//                return value < 4
//            })
//        
//            .tryDrop(while: { value in
//                if value == 3 {
//                    throw URLError(.badServerResponse)
//                }
//                
//                return value < 7
//            })
        
//            .prefix(4) // it gives первые 4 elements to us
        
//            .prefix(while: {$0 < 3}) // it gives первые elements while $0 < 3
        
//            .tryPrefix(while: { value in
//                if value == 3 {
//                    throw URLError(.badServerResponse)
//                }
//                
//                return value < 5
//            })
        
//            .output(at: 2) // it gives to us element that got 2 index
//            .output(in: 2..<5) // it gives to us elements that got index in range 2..<5
        */
        
        // Mathematic Operations
/*
//            .max() // Publishes the maximum value received from the upstream publisher, after it finishes.
        
//            .max(by: { first, second in
//                return first < second
//            })
 
//            .min() // Publishes the minimum value received from the upstream publisher, after it finishes.
        
//            .min(by: { first, second in
//                return first < second
//            })
        
//            .tryMin(by: { first, second in
//                return first < second
//            })
        */
        // Filter / Reduce Operations
        /*
//            .map{ String($0) }
        
//            .tryMap({ value in
//                if value == 5 {
//                    throw URLError(.badServerResponse)
//                }
//
//                return String(value)
//            })
        
//            .compactMap({ value in // we dont show 5
//                if value == 5 {
//                    return nil
//                }
//                
//                return String(value)
//            })
        
//            .tryCompactMap({ value in
//                if value == 9 {
//                    throw URLError(.badServerResponse)
//                }
//
//                if value == 5 {
//                    return nil
//                }
//
//                return String(value)
//            })
        
//            .filter({ value in // выводит только четные числа
//                return value % 2 == 0
//            })
        
//            .tryFilter()
        
//            .removeDuplicates() // removed duplicates
        
//            .removeDuplicates(by: { model1, model2 in
//                model1.value == model2.value
//            })
        
//            .tryRemoveDuplicates(by: )
        
//            .replaceNil(with: "Default string")) // replace all nil values as 5
        
//            .replaceEmpty(with: "Default string")) // replace all empty values as 5
        
//            .replaceError(with: "Default string") // replace all error values as 5
        
//            .scan(0, { existingValue, nextValue in
//                return existingValue + nextValue
//            })
//        
//            .tryScan(, )
        
//            .reduce(0, { existingValue, nextValue in
//                return existingValue + nextValue
//            })
        
//            .collect() // collect all values in array and then publisher is finished it gives to us that array
        
//            .collect(3) // добавляет по три элемента в массив и затем выводит его
            
//            .allSatisfy{$0 < 50} // check if all elements < 50 then return true else return false
        
//            .tryAllSatisfy()
        
        */
        
        // Timing Operations
        /*
//            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
        
//            .delay(for: 2, scheduler: DispatchQueue.main) // add delay
        
//            .measureInterval(using: DispatchQueue.main) // return intervval between values
        
//            .throttle(for: 3, scheduler: DispatchQueue.main, latest: true) // Публикует либо самый последний, либо первый элемент, опубликованный вышестоящим издателем за указанный промежуток времени.
        
//            .retry(3) // if we get error, we retry to get success response 3 times
        
//            .timeout(1, scheduler: DispatchQueue.main) // if time interval between responses < 0.75 then we finish this publisher */
        
        
        //Multiple Publishers / Subcribers
        /*
//            .combineLatest($anotherPublisher)
        
//            .combineLatest($anotherPublisher1, $anotherPublisher2)
        
//            .merge(with: $Publisher) // из двух publishers делает один (publisher  в .merge должен быть такого же типа как и основной publisher)
        
//            .catch({ error in // если у нас будет ошибка в первом основном publisher то тогда иы заменил основной publisher на $anotherPublisher и продолжим
//                return $anotherPublisher
//            })
         */
        
            .map{ String($0) }
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = error.localizedDescription
                    print(error.localizedDescription)
                    break
                }
            } receiveValue: { [weak self] returnedValue in
                self?.data.append(returnedValue)
//                self?.data = returnedValue // for collect
//                self?.data.append(contentsOf: returnedValue) // for collect(3)
            }
            .store(in: &cancellables)
    }
    
    func sharePublisher() {
        // if we wanna do several subcribers for one publisher
        
        let sharedPublisher = service.passthoughtPublisher
            .dropFirst()
            .share()
        
        sharedPublisher
            .map{ String($0) }
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = error.localizedDescription
                    print(error.localizedDescription)
                    break
                }
            } receiveValue: { [weak self] returnedValue in
                self?.data.append(returnedValue)
//                self?.data = returnedValue // for collect
//                self?.data.append(contentsOf: returnedValue) // for collect(3)
            }
            .store(in: &cancellables)
        
        sharedPublisher
            .map{ $0 > 4 ? true : false }
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = error.localizedDescription
                    print(error.localizedDescription)
                    break
                }
            } receiveValue: { [weak self] returnedValue in
                self?.data.append(returnedValue.description)
//                self?.data = returnedValue // for collect
//                self?.data.append(contentsOf: returnedValue) // for collect(3)
            }
            .store(in: &cancellables)
    }
}

struct AdvancedCombineBootcamp: View {
    
    @StateObject private var vm = AdvancedCombineViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.data, id: \.self) { item in
                    Text(item)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                if !vm.error.isEmpty {
                    Text(vm.error)
                }
            }
        }
    }
}

#Preview {
    AdvancedCombineBootcamp()
}
