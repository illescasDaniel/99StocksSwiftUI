//
//  CompanyEndpoint.swift
//  99_Companies
//
//  Created by Daniel Illescas Romero on 08/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation

extension Company {
	
	enum Endpoint: APIConfiguration {
		
		case companies
		case company(id: Int)
		
		//
		
		var baseURL: URLConvertible {
			"https://mobile.ninetynine.com/testapi/1/companies"
		}
		
		var path: String {
			switch self {
			case .companies:
				return "/"
			case .company(let id):
				return "/\(id)"
			}
		}
		
		var method: HTTPMethod {
			switch self {
			case .companies: return .get
			case .company: return .get
			}
		}
		
		var queryItems: [URLQueryItem] {
			switch self {
			case .companies: return []
			case .company: return []
			}
		}
		
		var bodyParameters: [String : Any]? {
			switch self {
			case .companies: return nil
			case .company: return nil
			}
		}
	}
}
