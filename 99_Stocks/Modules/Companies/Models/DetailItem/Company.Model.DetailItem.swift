//
//  CompanyDetail.swift
//  99_Companies
//
//  Created by Daniel Illescas Romero on 07/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import SwiftUI

extension Company.Model {
	struct DetailItem: Hashable, Identifiable {
		let id: Int
		let name: String
		let stockName: String
		let sharePrice: Double
		let description: String
		let country: String
	}

}
