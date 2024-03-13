//
//  NewMockDataService_Tests.swift
//  aboutSwiftUIAdvanced_Tests
//
//  Created by Вадим Мартыненко on 01.11.2023.
//

import XCTest
@testable import aboutSwiftUIAdvanced
import Combine

final class NewMockDataService_Tests: XCTestCase {

    var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        cancellables.removeAll()
    }

    func test_NewMockDataService_init_doesSetValuesCorrectly() {
        let items: [String]? = nil
        let items2: [String]? = []
        let items3: [String]? = [UUID().uuidString, UUID().uuidString]
        
        let dataService = NewMockDataService(items: items)
        let dataService2 = NewMockDataService(items: items2)
        let dataService3 = NewMockDataService(items: items3)
        
        XCTAssertFalse(dataService.items.isEmpty)
        XCTAssertTrue(dataService2.items.isEmpty)
        XCTAssertEqual(dataService3.items.count, items3?.count)
    }
    
    func test_NewMockDataService_downloadItemsWithEscaping_doesReturnValues() {
        let dataService = NewMockDataService(items: nil)
        
        var items: [String] = []
        let expection = XCTestExpectation()
        
        dataService.downloadItemsWithEscaping { returnedItems in
            items = returnedItems
            expection.fulfill()
        }
        
        wait(for: [expection], timeout: 5)
        
        XCTAssertEqual(items.count, dataService.items.count)
    }

    func test_NewMockDataService_downloadItemsWithCombine_doesReturnValues() {
        let dataService = NewMockDataService(items: nil)
        
        var items: [String] = []
        let expection = XCTestExpectation()
        
        dataService.downloadItemsWithCombine()
            .sink { completion in
                switch completion {
                case .finished:
                    expection.fulfill()
                case .failure:
                    XCTFail()
                }
            } receiveValue: { returnedItems in
                items = returnedItems
            }
            .store(in: &cancellables)

        
        wait(for: [expection], timeout: 5)
        
        XCTAssertEqual(items.count, dataService.items.count)
    }
    
    func test_NewMockDataService_downloadItemsWithCombine_doesFail() {
        let dataService = NewMockDataService(items: [])
        
        var items: [String] = []
        let expection = XCTestExpectation(description: "Does throw an error")
        let expection2 = XCTestExpectation(description: "Does throw URLError.badServerResponse")
        
        dataService.downloadItemsWithCombine()
            .sink { completion in
                switch completion {
                case .finished:
                    XCTFail()
                case .failure(let error):
                    expection.fulfill()
                    
                    let urlError = error as? URLError
                    XCTAssertEqual(urlError, URLError(.badServerResponse))
                    
                    if urlError == URLError(.badServerResponse) {
                        expection2.fulfill()
                    }
                }
            } receiveValue: { returnedItems in
                items = returnedItems
            }
            .store(in: &cancellables)

        
        wait(for: [expection, expection2], timeout: 5)
        
        XCTAssertEqual(items.count, dataService.items.count)
    }
}
