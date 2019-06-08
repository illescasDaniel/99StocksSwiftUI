//
//  APIConfiguration.swift
//  99_Companies
//
//  Created by Daniel Illescas Romero on 08/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation
import Combine

// HELPERS

public enum HTTPMethod: String {
	case get
	case post
	case put
	case delete
	case patch
}

public enum HTTPHeaderField: String {
	case authentication = "Authorization"
	case contentType = "Content-Type"
	case acceptType = "Accept"
	case acceptEncoding = "Accept-Encoding"
}

public enum ContentType: String {
	case json = "application/json"
	// ...
}


//
public enum URLError: Error {
	case badURL
}
public protocol URLConvertible {
	//associatedtype URLConversionError: Error
	func asURL() -> Result<URL, URLError>
}
extension String: URLConvertible {
	public func asURL() -> Result<URL, URLError> {
		let url = URL(string: self)
		switch url {
		case .none:
			return .failure(.badURL)
		case .some(let validURL):
			return .success(validURL)
		}
	}
}
extension URL: URLConvertible {
	public func asURL() -> Result<URL, URLError> {
		return .success(self)
	}
}

//

public enum URLRequestError: Error {
	case wrongURLConversion(URLError)
	case badSerialization
	// ...
}
public protocol URLRequestConvertible {
	//associatedtype RequestError: Error
	func asURLRequest() -> Result<URLRequest, URLRequestError>
}

public protocol APIConfiguration: URLRequestConvertible {
	//associatedtype APIClientReference: APIClient
	
	var baseURL: URLConvertible { get }
	var path: String { get }
	var method: HTTPMethod { get }
	var queryItems: [URLQueryItem] { get }
	var bodyParameters: [String: Any]? { get }
	
	func asURLRequest() -> Result<URLRequest, URLRequestError>
}

public extension APIConfiguration {
	
	func asURLRequest() -> Result<URLRequest, URLRequestError> {
		
		var url: URL!
		let urlResult = self.baseURL.asURL()
		
		switch urlResult {
		case .success(let validURL):
			url = validURL
		case .failure(let urlError):
			return .failure(.wrongURLConversion(urlError))
		}
		
		
		let urlWithPath = url.appendingPathComponent(self.path)
		var urlComponents = URLComponents(url: urlWithPath, resolvingAgainstBaseURL: true)
		urlComponents?.queryItems = self.queryItems
		
		var urlRequest = URLRequest(url: urlComponents?.url?.absoluteURL ?? urlWithPath)
		urlRequest.httpMethod = self.method.rawValue
		urlRequest.setValue(ContentType.json.rawValue,
							forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
		urlRequest.setValue(ContentType.json.rawValue,
							forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
		
		if let bodyParameters = bodyParameters {
			do {
				urlRequest.httpBody = try JSONSerialization.data(withJSONObject: bodyParameters, options: [])
			} catch {
				return .failure(.badSerialization)
			}
		}
		
		return .success(urlRequest)
	}
}

//

/*enum CompaniesEndpoint: APIConfiguration {
	
	case companies
	case company(id: Int)
	
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
	
	//typealias APIClientReference = <#type#>
}

enum CompaniesApiClient: APIClient {
	typealias APIConfigType = CompaniesEndpoint
	
}
protocol CompaniesApiClientProtocol {
	static func companies() -> AnyPublisher<[CompanyEntryResponse], Error>
}
extension CompaniesApiClient: CompaniesApiClientProtocol {
	static func companies() -> AnyPublisher<[CompanyEntryResponse], Error> {
		self.request(CompaniesEndpoint.companies)
	}
}

*/
