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

extension Company.ViewModel {
	
	final class ItemList: BindableObject {
		
		// MARK: - Properties
		
		/// Whenever a property that we specify changes, the view will be updated by sending a signal to it
		internal let didChange = PassthroughSubject<Company.ViewModel.ItemList, Never>()
		
		/// Dictionary indicating the stock state (neutral, growing or falling) and its prices, accessed by a company ID
		private(set) var stockState: [Company.Model.ItemList.ID: (state: Company.Model.SharePriceState, price: Double)] = [:] {
			didSet {
				didChange.send(self)
			}
		}
		private var data: [Company.Model.ItemList] = [] {
			didSet {
				didChange.send(self)
			}
		}
		private var filteredData: [Company.Model.ItemList] = [] {
			didSet {
				didChange.send(self)
			}
		}
		
		var realData: [Company.Model.ItemList] {
			return self.searchText.isEmpty ? self.data : self.filteredData
		}
		
		var searchText: String = "" {
			didSet {
				if !self.searchText.isEmpty {
					let lowercasedText = self.searchText.lowercased()

					self.filteredData = self.data.filter { $0.name.lowercased().range(of: lowercasedText) != nil }.sorted(by: { (lhs, rhs) in
						lhs.name.hasPrefix(self.searchText)
					})
					if self.filteredData.isEmpty {
						self.filteredData = self.data.filter { $0.stockName.lowercased().range(of: lowercasedText) != nil }.sorted(by: { (lhs, rhs) in
							lhs.stockName.hasPrefix(self.searchText)
						})
					}
					if self.filteredData.isEmpty {
						self.filteredData = self.data.filter { String($0.sharePrice).range(of: self.searchText) != nil }.sorted(by: { (lhs, rhs) in
							String(lhs.sharePrice).hasPrefix(self.searchText)
						})
					}
				}
				didChange.send(self)
			}
		}
		
		// MARK: - Initializers

		init(initialData: [Company.Model.ItemList] = [], scheduleToReloadEvery timeInterval: TimeInterval? = 15) {
			fetchCompanies()
			if let timeInterval = timeInterval {
				reloadEvery(timeInterval)
			}
		}
		
		// MARK: - Public methods
		
		func reload() {
			self.fetchCompanies()
		}
		
		func stockState(for companyId: Company.Model.ItemList.ID) -> Company.Model.SharePriceState {
			stockState[companyId, default: (.neutral, 0)].state
		}
		
		// MARK: - Convenience
		
		private func fetchCompanies() {
			_ = Company.Network.ApiClient.companies().map { response in
					response.map { Company.Model.ItemList(id: $0.id, name: $0.name, stockName: $0.stockName, sharePrice: $0.sharePrice) }
				}.sink { (result) in
					DispatchQueue.main.async {
						self.data = result.sorted(by: >)
						/// Updates the stockState dictionary accordingly, so it later changes the share price colors in the view
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
									else if company.sharePrice > previousPrice && previousStockState != .up {
										self.stockState[company.id] = (.up, company.sharePrice)
									}
									else if company.sharePrice < previousPrice && previousStockState != .down {
										self.stockState[company.id] = (.down, company.sharePrice)
									}
								}
							}
						}
					}
			}
		}
		
		private func reloadEvery(_ timeInterval: TimeInterval) {
			Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) {_ in
				if self.searchText.isEmpty {
					self.fetchCompanies()
				}
			}
		}
	}
}
#if DEBUG
extension Company.ViewModel.ItemList {
	/// Only used in the preview and maybe when the user doesn't have internet (not implemented)
	static var mockData: [Company.Model.ItemList] {[
		.init(id: 1, name: "Apple", stockName: "APPL", sharePrice: 226.304),
		.init(id: 2, name: "Microsoft Corporation", stockName: "MSFT", sharePrice: 104.799),
		.init(id: 3, name: "Alphabet Inc.", stockName: "GOOG", sharePrice: 1124.317),
		.init(id: 4, name: "Amazon.com", stockName: "AMZN", sharePrice: 1900.535),
		.init(id: 5, name: "Facebook", stockName: "FB", sharePrice: 164.963),
		.init(id: 6, name: "Berkshire Hathaway", stockName: "BRK.A", sharePrice: 339465.146),
		.init(id: 7, name: "Alibaba Group Holding Ltd", stockName: "BABA", sharePrice: 141.808),
		.init(id: 8, name: "Johnson & Johnson", stockName: "JNJ", sharePrice: 151.82),
		.init(id: 9, name: "JPMorgan Chase & Co.", stockName: "JPM", sharePrice: 120.593),
		.init(id: 10, name: "ExxonMobil Corporation", stockName: "XOM", sharePrice: 84.103)
	]}
}
#endif
