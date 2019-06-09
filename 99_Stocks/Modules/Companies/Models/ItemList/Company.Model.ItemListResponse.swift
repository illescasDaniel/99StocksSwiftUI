//
//  CompanyEntryResponse.swift
//  99_Companies
//
//  Created by Daniel Illescas Romero on 08/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation

extension Company.Model {
	/*
	- EXAMPLE
	{
		"id": 1,
		"name": "Apple Inc.",
		"ric": "APPL",
		"sharePrice": 226.304
	}
	*/
	/// We asume no fields will be nil and every field will be present, else the field should be Optional
	/// On a real world app, as we have the real full API specification we would already know which fields are nullable or not
	struct ItemListResponse: Decodable {
		
		let id: Int
		let name: String
		let stockName: String
		let sharePrice: Double
		
		enum CodingKeys: String, CodingKey {
			case id, name
			case stockName = "ric"
			case sharePrice
		}
	}
}
