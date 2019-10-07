//
//  CompanyDetails.swift
//  99_Companies
//
//  Created by Daniel Illescas Romero on 08/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

extension Company.ViewModel {
	
	final class DetailItem: ObservableObject {
		
		internal let didChange = PassthroughSubject<Company.ViewModel.DetailItem, Never>()
		
		private let companyId: Company.Model.ItemList.ID
		private(set) var stockState: Company.Model.SharePriceState = .neutral {
			didSet {
				didChange.send(self)
			}
		}
		
		private var previousStock: (state: Company.Model.SharePriceState, price: Double)?
		private(set) var sharePrices: [(x: Int, y: Double)] = [] {
			didSet {
				didChange.send(self)
			}
		}
		
		var data: Company.Model.DetailItem? {
			didSet {
				didChange.send(self)
			}
		}
		
		init(companyId: Company.Model.ItemList.ID, initialData: Company.Model.DetailItem? = nil, scheduleToReloadEvery timeInterval: TimeInterval? = 15) {
			self.companyId = companyId
			self.data = initialData
			fetchCompanyById()
			if let timeInterval = timeInterval {
				reloadEvery(timeInterval)
			}
		}
		
		func reload() {
			self.fetchCompanyById()
		}
		
		var image: Image? {
			guard let stockName = Company.Model.StockName(rawValue: self.company.stockName) else { return nil }
			return stockName.companyIcon
		}
		
		// MARK: - Convenience
		
		private func fetchCompanyById() {
			_ = Company.Network.ApiClient.company(id: self.companyId).map {
				Company.Model.DetailItem(id: $0.id, name: $0.name, stockName: $0.stockName, sharePrice: $0.sharePrice, description: $0.description, country: $0.country)
			}.sink(receiveCompletion: { _ in }, receiveValue: { result in
				DispatchQueue.main.async {
					self.data = result
					if let previousStock = self.previousStock {
						if result.sharePrice == previousStock.price && previousStock.state != .neutral {
							self.previousStock = (.neutral, result.sharePrice)
							self.stockState = .neutral
						} else if result.sharePrice > previousStock.price && previousStock.state != .up {
							self.previousStock = (.up, result.sharePrice)
							self.stockState = .up
						} else if result.sharePrice < previousStock.price && previousStock.state != .down {
							self.previousStock = (.down, result.sharePrice)
							self.stockState = .down
						}
					} else {
						self.previousStock = (.neutral, result.sharePrice)
					}
					let previousCount = self.sharePrices.count
					self.sharePrices.append((x: previousCount, y: result.sharePrice))
				}
			})
		}
		
		private func reloadEvery(_ timeInterval: TimeInterval) {
			Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) {_ in
				self.fetchCompanyById()
			}
		}
	}

}

extension Company.ViewModel.DetailItem {
	var company: Company.Model.DetailItem {
		if let companyDetail = self.data {
			return companyDetail
		}
		return .init(id: 0, name: "-", stockName: "-", sharePrice: 0, description: "", country: "")
	}
	func stockNameAndPossiblyItsFlag() -> String {
		if let countryFlag = Company.Model.Country(rawValue: self.company.country)?.emojiFlag {
			return self.company.stockName + " " + countryFlag
		} else {
			return self.company.stockName
		}
	}
}
#if DEBUG
/// Only used in the preview and maybe when the user doesn't have internet (not implemented)
extension Company.ViewModel.DetailItem {
	static var mockData: Company.Model.DetailItem {
		.init(id: 1,
			name: "Apple",
			stockName: "APPL",
			sharePrice: 1023.1,
			description: "Lorem ipsum is your friend ;)",
			country: "United States of America")
	}
}
#endif
