//
//  UnitTestingViewModel_Tests.swift
//  aboutSwiftUIAdvanced_Tests
//
//  Created by Вадим Мартыненко on 31.10.2023.
//

import XCTest
@testable import aboutSwiftUIAdvanced
import Combine

// Naming structure: test_UnitOfWork_StateUnderText_ExpectedBehavior
// Naming Structure: test_[struct or class]_[variable or function]_[expected result]
// Testing structure: Given, When, Then

final class UnitTestingViewModel_Tests: XCTestCase {
    
    var viewModel: UnitTestingViewModel?
    var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // This method is called before start each test
        
        viewModel = UnitTestingViewModel(isPremium: Bool.random())
    }

    override func tearDownWithError() throws {
        // This method is called after start each test
        
        viewModel = nil
        
        cancellables.removeAll()
    }

    
    func test_UnitTestingViewModel_isPremium_shouldBeTrue() {
        // Given
        
        let isPremium: Bool = true
        
        // When
        
        let vm = UnitTestingViewModel(isPremium: isPremium)
        
        // Then
        
        XCTAssertTrue(vm.isPremium) // мы проверяем что vm.isPremium равно true
    }
    
    func test_UnitTestingViewModel_isPremium_shouldBeFalse() {
        // Given
        
        let isPremium: Bool = false
        
        // When
        
        let vm = UnitTestingViewModel(isPremium: isPremium)
        
        // Then
        
        XCTAssertFalse(vm.isPremium) // мы проверяем что vm.isPremium равно false
    }
    
    func test_UnitTestingViewModel_isPremium_shouldBeInjectedValue() {
        // Given
        
        let isPremium: Bool = Bool.random()
        
        // When
        
        let vm = UnitTestingViewModel(isPremium: isPremium)
        
        // Then
        
        XCTAssertEqual(vm.isPremium, isPremium) // мы проверяем что vm.isPremium равно isPremium
    }
    
    func test_UnitTestingViewModel_isPremium_shouldBeInjectedValue_stressed() {
        for _ in 0..<10 {
            // Given
            
            let isPremium: Bool = Bool.random()
            
            // When
            
            let vm = UnitTestingViewModel(isPremium: isPremium)
            
            // Then
            
            XCTAssertEqual(vm.isPremium, isPremium) // мы проверяем что vm.isPremium равно isPremium
        }
    }
    
    func test_UnitTestingViewModel_dataArray_shouldBeEmpty() {
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingViewModel_dataArray_shouldBeEmpty2() {
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingViewModel_dataArray_shouldAddItems() {
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        let loopCount: Int = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        
        XCTAssertFalse(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, loopCount)
        XCTAssertNotEqual(vm.dataArray.count, 0)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
        
        // XCTAssertGreaterThanOrEqual
        // XCTAssertLessThan
        // XCTAssertLessThanOrEqual
    }

    func test_UnitTestingViewModel_dataArray_shouldNotAddBlankString() {
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        vm.addItem(item: "")
        
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    func test_UnitTestingViewModel_selectedItem_shouldStartAsNil() {
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestingViewModel_selectedItem_shouldBeNilWhenSelectedInvalidItem() {
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        let newItem = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectItem(item: newItem)
        
        vm.selectItem(item: UUID().uuidString)
        
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestingViewModel_selectedItem_shouldBeSelected() {
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        let newItem = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectItem(item: newItem)
        
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, newItem)
    }
    
    func test_UnitTestingViewModel_selectedItem_shouldBeSelected_stress() {
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        let loopCount: Int = Int.random(in: 1..<100)
        var itemsArray: [String] = []
        
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        
        let randomItem: String = itemsArray.randomElement() ?? ""
        
        XCTAssertFalse(randomItem.isEmpty)
        
        vm.selectItem(item: randomItem)
        
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, randomItem)
    }
    
    func test_UnitTestingViewModel_saveItem_shouldThrowError_itemNotFound() {
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        let loopCount: Int = Int.random(in: 1..<100)
        
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString), "Should Throw Item Not Found") { error in
            let returnedError = error as? UnitTestingViewModel.DataErrors
            
            XCTAssertEqual(returnedError, UnitTestingViewModel.DataErrors.itemNotFound)
        }
    }
    
    func test_UnitTestingViewModel_saveItem_shouldThrowError_noData() {
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        let loopCount: Int = Int.random(in: 1..<100)
        
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        
        XCTAssertThrowsError(try vm.saveItem(item: ""), "Should Throw No Data") { error in
            let returnedError = error as? UnitTestingViewModel.DataErrors
            
            XCTAssertEqual(returnedError, UnitTestingViewModel.DataErrors.noData)
        }
    }
    
    func test_UnitTestingViewModel_saveItem_shouldSaveItem() {
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        let loopCount: Int = Int.random(in: 1..<100)
        var itemsArray: [String] = []
        
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        
        let randomItem: String = itemsArray.randomElement() ?? ""
        
        XCTAssertFalse(randomItem.isEmpty)
        
        XCTAssertNoThrow(try vm.saveItem(item: randomItem))
    }
    
    func test_UnitTestingViewModel_downloadWithEscaping_shouldReturnItems() {
        guard let viewModel else { return }
        
        let expectation = XCTestExpectation(description: "Should return items after 3 seconds")
        
        viewModel.$dataArray
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.downloadWithEscaping()
        
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(viewModel.dataArray.count, 0)
    }
    
    func test_UnitTestingViewModel_downloadWithCombine_shouldReturnItems() {
        guard let viewModel else { return }
        
        let expectation = XCTestExpectation(description: "Should return items after a second")
        
        viewModel.$dataArray
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.downloadWithCombine()
        
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(viewModel.dataArray.count, 0)
    }
    
    func test_UnitTestingViewModel_downloadWithCombine_shouldReturnItems2() {
        let items: [String] = [UUID().uuidString, UUID().uuidString, UUID().uuidString]
        let dataService: NewDataServiceProtocol = NewMockDataService(items: items)
        let viewModel = UnitTestingViewModel(isPremium: Bool.random(), dataService: dataService)
        
        let expectation = XCTestExpectation(description: "Should return items after a second")
        
        viewModel.$dataArray
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.downloadWithCombine()
        
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(viewModel.dataArray.count, 0)
        XCTAssertEqual(viewModel.dataArray.count, items.count)
    }
}
