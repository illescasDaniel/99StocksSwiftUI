//
//  StockName.swift
//  99_Stocks
//
//  Created by Daniel Illescas Romero on 09/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import SwiftUI

extension Company.Model {
	
	/// This will allow us match them againts predefined images
	/// of the companies that are located in the assets folder
	enum StockName: String {
		
		case apple = "APPL"
		case amazon = "AMZN"
		case microsoft = "MSFT"
		case alphabet = "GOOG"
		case facebook = "FB"
		case berkshire = "BRK.A"
		case alibaba = "BABA"
		case johnson = "JNJ"
		case jpmorgan = "JPM"
		
		var companyIcon: Image {
			typealias I = Images.Companies
			switch self {
			case .apple: return I.apple
			case .amazon: return I.amazon
			case .microsoft: return I.microsoft
			case .alphabet: return I.alphabet
			case .facebook: return I.facebook
			case .berkshire: return I.berkshire
			case .alibaba: return I.alibaba
			case .johnson: return I.johnson
			case .jpmorgan: return I.jpmorgan
			}
		}
	}

}
