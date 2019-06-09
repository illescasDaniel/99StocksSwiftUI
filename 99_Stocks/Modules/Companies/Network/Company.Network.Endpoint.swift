//
//  CompanyEndpoint.swift
//  99_Companies
//
//  Created by Daniel Illescas Romero on 08/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation

extension Company.Network {
	// The `APIConfiguration` implementation was automatically generated,
	// you can find the generated code under the "GeneratedCode" folder
	// sourcery: url = "https://mobile.ninetynine.com/testapi/1/companies"
	enum Endpoint: APIConfiguration {
		// sourcery: response = [Company.Model.ItemListResponse]
		case companies
		// sourcery: path = "/\(id)", response = Company.Model.DetailItemResponse
		case company(id: Int)
	}
}
