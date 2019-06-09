//
//  _9_CompaniesTests.swift
//  99_CompaniesTests
//
//  Created by Daniel Illescas Romero on 07/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import XCTest
import Combine
@testable import _9_Stocks

class StocksAPITests: XCTestCase {

	// MARK: - Preparation
	
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
	
	// MARK: - Tests
	
	func testRawFetchCompanies() {
		guard let url = try? Company.Network.Endpoint.companies.baseURL.asURL().get() else {
			XCTFail("Invalid URL")
			return
		}
		let expectation = XCTestExpectation(description: "RAW Fetch companies")
		let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
			XCTAssertNotNil(data)
			XCTAssertNotNil(response)
			if let httpResponse = response as? HTTPURLResponse {
				XCTAssertTrue(200..<300 ~= httpResponse.statusCode, "Bad request")
			}
			XCTAssertNil(error, error?.localizedDescription ?? "error")
			expectation.fulfill()
		}
		task.resume()
		wait(for: [expectation], timeout: 20)
	}

    func testRealCompaniesAPI() {
		let expectation = XCTestExpectation(description: "Fetch companies")
		fetchCompanies(onNext: { companies in
			XCTAssert(!companies.isEmpty)
			expectation.fulfill()
		}, onError: { error in
			XCTFail(error.localizedDescription)
		})
		wait(for: [expectation], timeout: 20)
    }
	
	func testRealCompanyItemDetailAPI() {
		let expectation = XCTestExpectation(description: "Fetch company")
		fetchCompany(id: 1, onNext: { company in
			expectation.fulfill()
		}, onError: { error in
			XCTFail(error.localizedDescription)
		})
		wait(for: [expectation], timeout: 20)
	}
	
	// MARK: - Convenience
	
	private func fetchCompanies(onNext: @escaping ([Company.Model.ListEntryResponse]) -> Void, onError: @escaping (Error) -> Void) {
		_ = Company.Network.ApiClient.companies().sink(receiveCompletion: { completion in
			switch completion {
			case .failure(let error):
				onError(error)
			case .finished: return
			}
		}, receiveValue: { value in
			onNext(value)
		})
	}
	
	private func fetchCompany(id: Int, onNext: @escaping (Company.Model.DetailItemResponse) -> Void, onError: @escaping (Error) -> Void) {
		_ = Company.Network.ApiClient.company(id: id).sink(receiveCompletion: { completion in
			switch completion {
			case .failure(let error):
				onError(error)
			case .finished: return
			}
		}, receiveValue: { value in
			onNext(value)
		})
	}
}
