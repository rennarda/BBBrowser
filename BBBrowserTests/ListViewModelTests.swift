//
//  ListViewModelTests.swift
//  BBBrowserTests
//
//  Created by Andrew Rennard on 24/04/2021.
//

import XCTest
@testable import BBBrowser

class ListViewModelTests: XCTestCase {
    var viewModel: ListViewModel!
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test_filterCharacters() throws {
        let expectation = expectation(description: "Load and filter expectation")
        viewModel = ListViewModel(apiClient: MockAPIClient(fixtureName: "4characters"))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModel.filteredCharacters.count, 4)
            self.viewModel.filterText = "walter white"
            XCTAssertEqual(self.viewModel.filteredCharacters.count, 2)
            self.viewModel.filterText = "Walter White"
            XCTAssertEqual(self.viewModel.filteredCharacters.count, 2)
            self.viewModel.filterText = "Walter White Jr."
            XCTAssertEqual(self.viewModel.filteredCharacters.count, 1)
            self.viewModel.filterText = "weifjowignoitgn"
            XCTAssertEqual(self.viewModel.filteredCharacters.count, 0)

            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
}
