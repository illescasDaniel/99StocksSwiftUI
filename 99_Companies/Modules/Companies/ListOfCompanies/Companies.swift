//
//  CompaniesViewModel.swift
//  99_Companies
//
//  Created by Daniel Illescas Romero on 08/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class Companies: BindableObject {
	
	internal let didChange = PassthroughSubject<Companies, Never>()
	
	private(set) var stockState: [CompanyEntry.ID: (state: CompanyStockState, price: Double)] = [:] {
		didSet {
			didChange.send(self)
		}
	}
	var data: [CompanyEntry] = [] {
		didSet {
			didChange.send(self)
		}
	}
	
	func stockState(for companyId: CompanyEntry.ID) -> CompanyStockState{
		stockState[companyId, default: (.neutral, 0)].state
	}

	init(initialData: [CompanyEntry] = [], scheduleToReloadEvery timeInterval: TimeInterval? = 15) {
		fetchCompanies()
		if let timeInterval = timeInterval {
			reloadEvery(timeInterval)
		}
	}
	
	//func filter(by keypath)
	
	func reload() {
		self.fetchCompanies()
	}
	
	// MARK: - Convenience
	
	private func fetchCompanies() {
		_ = Company.ApiClient.companies().map { response in
				response.map { CompanyEntry(id: $0.id, name: $0.name, stockName: $0.stockName, sharePrice: $0.sharePrice) }
			}.sink { (result) in
				DispatchQueue.main.async {
					self.data = result.sorted(by: >)
					if self.stockState.isEmpty {
						for company in self.data {
							self.stockState[company.id] = (.neutral, company.sharePrice)
						}
					} else {
						for company in self.data {
							if let (previousStockState, previousPrice) = self.stockState[company.id] {
								if company.sharePrice == previousPrice && previousStockState != .neutral {
									self.stockState[company.id] = (.neutral, company.sharePrice)
								}
								else if company.sharePrice > previousPrice && previousStockState != .growing {
									self.stockState[company.id] = (.growing, company.sharePrice)
								}
								else if company.sharePrice < previousPrice && previousStockState != .falling {
									self.stockState[company.id] = (.falling, company.sharePrice)
								}
							}
						}
					}
				}
		}
	}
	
	private func reloadEvery(_ timeInterval: TimeInterval) {
		Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) {_ in
			self.fetchCompanies()
		}
	}
}
extension Companies {
	enum CompanyStockState: String, Decodable {
		case neutral
		case growing
		case falling
		
		var directionImageName: String {
			switch self {
			case .neutral:
				return "equal"
			case .growing:
				return "arrowtriangle.up.fill"
			case .falling:
				return "arrowtriangle.down.fill"
			}
		}
		var color: Color {
			switch self {
			case .neutral:
				return Colors.Currency.neutral
			case .growing:
				return Colors.Currency.growing
			case .falling:
				return Colors.Currency.falling
			}
		}
	}
}
extension Companies {
	static var mockData: [CompanyEntry] {[
		CompanyEntry(id: 1, name: "Apple", stockName: ".amazon", sharePrice: 100.0),
		CompanyEntry(id: 2, name: "Microsoft Corporation", stockName: ".amazon", sharePrice: 100.1),
		CompanyEntry(id: 3, name: "Facebook", stockName: ".amazon", sharePrice: 100.1),
		CompanyEntry(id: 4, name: "Apple4", stockName: ".amazon", sharePrice: 100.1),
		CompanyEntry(id: 5, name: "Apple5", stockName: ".amazon", sharePrice: 100.1),
		CompanyEntry(id: 6, name: "Apple6", stockName: ".amazon", sharePrice: 100.1),
		CompanyEntry(id: 7, name: "Apple7", stockName: ".amazon", sharePrice: 100.1),
		CompanyEntry(id: 8, name: "Apple8", stockName: ".amazon", sharePrice: 100.1),
		CompanyEntry(id: 9, name: "Apple9", stockName: ".amazon", sharePrice: 100.1),
		CompanyEntry(id: 10, name: "Apple10", stockName: ".amazon", sharePrice: 1000.1)
		]}
	
}
