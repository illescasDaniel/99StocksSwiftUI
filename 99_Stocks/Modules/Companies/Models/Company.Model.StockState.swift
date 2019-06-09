//
//  CompanyStockState.swift
//  99_Stocks
//
//  Created by Daniel Illescas Romero on 09/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import SwiftUI

extension Company.Model {
	
	/// For when a price drops, goes up or states the same
	enum SharePriceState: String {
		case neutral
		case up
		case down
		
		var directionImage: Image? {
			switch self {
			case .neutral:
				return nil//Images.Companies.SharePriceState.neutral
			case .up:
				return Images.Companies.SharePriceState.up
			case .down:
				return Images.Companies.SharePriceState.down
			}
		}
		var color: Color {
			switch self {
			case .neutral:
				return Colors.Companies.Currency.neutral
			case .up:
				return Colors.Companies.Currency.up
			case .down:
				return Colors.Companies.Currency.down
			}
		}
	}

}
