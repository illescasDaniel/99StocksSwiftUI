
//
//  Helpers.swift
//  99_Stocks
//
//  Created by Daniel Illescas Romero on 09/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation

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
	func asURLRequest() -> Result<URLRequest, URLRequestError>
}
