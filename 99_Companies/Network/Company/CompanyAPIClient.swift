//
//  CompanyAPIClient.swift
//  99_Companies
//
//  Created by Daniel Illescas Romero on 08/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation
import Combine

extension Company {
	enum ApiClient: APIClient {
		typealias APIConfigType = Endpoint
	}
}

protocol CompanyApiClientProtocol {
	static func companies() -> AnyPublisher<[CompanyEntryResponse], Error>
	static func company(id: Int) -> AnyPublisher<CompanyDetailResponse, Error>
}
extension Company.ApiClient: CompanyApiClientProtocol {
	static func companies() -> AnyPublisher<[CompanyEntryResponse], Error> {
		self.request(Company.Endpoint.companies)
	}
	static func company(id: Int) -> AnyPublisher<CompanyDetailResponse, Error> {
		self.request(Company.Endpoint.company(id: id))
	}
}

