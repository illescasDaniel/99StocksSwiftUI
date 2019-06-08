//
//  CompanyDetail.swift
//  99_Companies
//
//  Created by Daniel Illescas Romero on 07/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import SwiftUI

enum Country: String {
	case usa = "United States of America"
	case spain = "Spain"
	case italy = "Italy"
	
	var emojiFlag: String {
		switch self {
		case .usa: return "🇺🇸"
		case .spain: return "🇪🇸"
		case .italy: return "🇮🇹"
		}
	}
}

struct CompanyDetail: Hashable, Identifiable {
	let id: Int
	let name: String
	let stockName: String
	let sharePrice: Double
	let description: String
	let country: String
}
