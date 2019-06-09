//
//  Country.swift
//  99_Stocks
//
//  Created by Daniel Illescas Romero on 09/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation

extension Company.Model {
	
	/// If we match the country, we can put their flag
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

}
