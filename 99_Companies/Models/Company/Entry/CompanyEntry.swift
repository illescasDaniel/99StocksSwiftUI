//
//  CompanyEntry.swift
//  99_Companies
//
//  Created by Daniel Illescas Romero on 07/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import SwiftUI
/*
[
{
"id": 1,
"name": "Apple Inc.",
"ric": "APPL",
"sharePrice": 226.304
},
{
"id": 2,
"name": "Microsoft Corporation",
"ric": "MSFT",
"sharePrice": 104.799
},
{
"id": 3,
"name": "Alphabet Inc.",
"ric": "GOOG",
"sharePrice": 1124.317
},
{
"id": 4,
"name": "Amazon.com, Inc.",
"ric": "AMZN",
"sharePrice": 1900.535
},
{
"id": 5,
"name": "Facebook",
"ric": "FB",
"sharePrice": 164.963
},
{
"id": 6,
"name": "Berkshire Hathaway",
"ric": "BRK.A",
"sharePrice": 339465.146
},
{
"id": 7,
"name": "Alibaba Group Holding Ltd",
"ric": "BABA",
"sharePrice": 141.808
},
{
"id": 8,
"name": "Johnson & Johnson",
"ric": "JNJ",
"sharePrice": 151.82
},
{
"id": 9,
"name": "JPMorgan Chase & Co.",
"ric": "JPM",
"sharePrice": 120.593
},
{
"id": 10,
"name": "ExxonMobil Corporation",
"ric": "XOM",
"sharePrice": 84.103
}
]
*/
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
	//case exxonMobil = "XOM"
	
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
		// case .exxonMobil:?
		}
	}
}

struct CompanyEntry: Hashable, Identifiable {
	let id: Int
	let name: String
	let stockName: String
	let sharePrice: Double
}
extension CompanyEntry: Comparable {
	static func < (lhs: CompanyEntry, rhs: CompanyEntry) -> Bool {
		return lhs.sharePrice < rhs.sharePrice
	}
}
