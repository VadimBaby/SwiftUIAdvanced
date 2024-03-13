//
//  UnitTestingViewModel.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 31.10.2023.
//

import Foundation
import Combine

class UnitTestingViewModel: ObservableObject {
    @Published var isPremium: Bool
    @Published var dataArray: [String] = []
    @Published var selectedItem: String? = nil
    
    let dataService: NewDataServiceProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(isPremium: Bool, dataService: NewDataServiceProtocol = NewMockDataService(items: nil)) {
        self.isPremium = isPremium
        self.dataService = dataService
    }
    
    func addItem(item: String) {
        guard !item.isEmpty else { return }
        
        self.dataArray.append(item)
    }
    
    func selectItem(item: String) {
        if let x = dataArray.first(where: {$0 == item }) {
            selectedItem = x
        } else {
            selectedItem = nil
        }
    }
    
    func saveItem(item: String) throws {
        guard !item.isEmpty else { throw DataErrors.noData }
        
        if let x = dataArray.first(where: {$0 == item }) {
            print("item saved")
        } else {
            throw DataErrors.itemNotFound
        }
    }
    
    enum DataErrors: LocalizedError {
        case noData
        case itemNotFound
    }
    
    func downloadWithEscaping() {
        dataService.downloadItemsWithEscaping { [weak self] returnedItems in
            guard let self = self else { return }
            
            self.dataArray = returnedItems
        }
    }
    
    func downloadWithCombine() {
        dataService.downloadItemsWithCombine()
            .sink { _ in
                
            } receiveValue: { [weak self] returnedItems in
                guard let self = self else { return }
                
                self.dataArray = returnedItems
            }
            .store(in: &cancellables)
    }
}
