//
//  APIConfiguration.swift
//  99_Companies
//
//  Created by Daniel Illescas Romero on 08/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation
import Combine

public protocol APIConfiguration: URLRequestConvertible {
	
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
