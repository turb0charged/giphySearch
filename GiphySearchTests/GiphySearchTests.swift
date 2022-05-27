//
//  GiphySearchTests.swift
//  GiphySearchTests
//
//  Created by on 5/27/22.
//

import XCTest
@testable import GiphySearch

class GiphySearchTests: XCTestCase {
    private var viewModel: GifSearchViewModel!
    private var mockNetworkingService: NetworkingServiceMock!

    override func setUp() {
        super.setUp()
        mockNetworkingService = NetworkingServiceMock()
        viewModel = GifSearchViewModel(networkingService: mockNetworkingService)
    }

    override func tearDown() {
        mockNetworkingService = nil
        viewModel = nil

        super.tearDown()
    }

    func testSuccess() async {
        mockNetworkingService.showError = false
        await viewModel.networkingService.request(query: "test") { [self] result in
            switch result {
                case .success(let data):
                    XCTAssertNotNil(data)
                    XCTAssertEqual(mockNetworkingService.getCallsCount, 1)
                    XCTAssertEqual(mockNetworkingService.getArguments.first, "test")
                case .failure(_):
                    XCTFail()
            }
        }
    }

    func testFailure() async {
        mockNetworkingService.showError = true
        await viewModel.networkingService.request(query: "failTest") { [self] result in
            switch result {
                case .success(_):
                    XCTFail()
                case .failure(let error):
                    XCTAssertNotNil(error)
                    XCTAssertEqual(mockNetworkingService.getCallsCount, 1)
                    XCTAssertEqual(mockNetworkingService.getArguments.first, "failTest")
            }
        }
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
