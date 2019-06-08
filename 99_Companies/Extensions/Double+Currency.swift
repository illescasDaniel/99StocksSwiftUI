//
//  Double+Money.swift
//  99_Companies
//
//  Created by Daniel Illescas Romero on 08/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation

extension Double {
	var currencyFormatted: String {
		let formatter = NumberFormatter()
		formatter.locale = Locale.current
		formatter.numberStyle = .currency
		return formatter.string(from: NSNumber(value: self))
			?? String(describing: self)
	}
}
