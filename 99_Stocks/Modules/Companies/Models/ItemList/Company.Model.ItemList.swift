//
//  CompanyEntry.swift
//  99_Companies
//
//  Created by Daniel Illescas Romero on 07/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import SwiftUI

extension Company.Model {
	struct ItemList: Hashable, Identifiable {
		let id: Int
		let name: String
		let stockName: String
		let sharePrice: Double
	}
}
extension Company.Model.ItemList: Comparable {
	static func < (lhs: Company.Model.ItemList, rhs: Company.Model.ItemList) -> Bool {
		return lhs.sharePrice < rhs.sharePrice
	}
}
