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

final class CompanyDetailsViewModel: BindableObject {
	
	internal let didChange = PassthroughSubject<CompanyDetailsViewModel, Never>()
	
	private let companyId: CompanyEntry.ID
	private(set) var stockState: Companies.CompanyStockState = .neutral {
		didSet {
			didChange.send(self)
		}
	}
	
	private var previousStock: (state: Companies.CompanyStockState, price: Double)?
	private(set) var sharePrices: [(x: Int, y: Double)] = [] {
		didSet {
			didChange.send(self)
		}
	}
	
	var data: CompanyDetail? {
		didSet {
			didChange.send(self)
		}
	}
	
	init(companyId: CompanyEntry.ID, initialData: CompanyDetail? = nil, scheduleToReloadEvery timeInterval: TimeInterval? = 15) {
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
		guard let stockName = StockName(rawValue: self.company.stockName) else { return nil }
		return stockName.companyIcon
	}
	
	// MARK: - Convenience
	
	private func fetchCompanyById() {
		_ = Company.ApiClient.company(id: self.companyId).map {
				CompanyDetail(id: $0.id, name: $0.name, stockName: $0.stockName, sharePrice: $0.sharePrice, description: $0.description, country: $0.country)
			}.sink { (result) in
				DispatchQueue.main.async {
					self.data = result
					if let previousStock = self.previousStock {
						if result.sharePrice == previousStock.price && previousStock.state != .neutral {
							self.previousStock = (.neutral, result.sharePrice)
							self.stockState = .neutral
						} else if result.sharePrice > previousStock.price && previousStock.state != .growing {
							self.previousStock = (.growing, result.sharePrice)
							self.stockState = .growing
						} else if result.sharePrice < previousStock.price && previousStock.state != .falling {
							self.previousStock = (.falling, result.sharePrice)
							self.stockState = .falling
						}
					} else {
						self.previousStock = (.neutral, result.sharePrice)
					}
					let previousCount = self.sharePrices.count
					self.sharePrices.append((x: previousCount, y: result.sharePrice))
				}
		}
	}
	
	private func reloadEvery(_ timeInterval: TimeInterval) {
		Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) {_ in
			self.fetchCompanyById()
		}
	}
}
extension CompanyDetailsViewModel {
	static var mockData: CompanyDetail {
		CompanyDetail(id: 1, // use real id
			name: "Apple",
			stockName: "APPL",
			sharePrice: 1023.1,
			description: "Lorem ipsum is your friend ;)",
			country: "United States of America")
	}
}
extension CompanyDetailsViewModel {
	var company: CompanyDetail {
		if let companyDetail = self.data {
			return companyDetail
		}
		return CompanyDetail(id: 0, name: "-", stockName: "-", sharePrice: 0, description: "", country: "")
	}
	func stockNameAndPossiblyItsFlag() -> String {
		if let countryFlag = Country(rawValue: self.company.country)?.emojiFlag {
			return self.company.stockName + " " + countryFlag
		} else {
			return self.company.stockName
		}
	}
}
