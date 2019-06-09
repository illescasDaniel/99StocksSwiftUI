//  URLSession+Combine.swift
//  Based on extensions from GitHubSearchWithSwiftUI, by marty-suzuki
//  https://github.com/marty-suzuki/GitHubSearchWithSwiftUI

import Combine
import Foundation

struct CombineExtension<Base> {
	let base: Base
	
	init(_ base: Base) {
		self.base = base
	}
}
extension URLSession {
	var combine: CombineExtension<URLSession> {
		return .init(self)
	}
}

extension CombineExtension where Base == URLSession {
	
	func send(request: URLRequest) -> Publishers.Future<Data, URLSessionError> {
		
		Publishers.Future<Data, URLSessionError> { [base] subscriber in
			
			let task = base.dataTask(with: request) { data, response, error in
				
				guard let response = response as? HTTPURLResponse else {
					subscriber(.failure(.invalidResponse))
					return
				}
				
				guard 200..<300 ~= response.statusCode else {
					let sessionError: URLSessionError
					if let data = data {
						sessionError = .serverErrorMessage(statusCode: response.statusCode,
														   data: data)
					} else {
						sessionError = .serverError(statusCode: response.statusCode,
													error: error)
					}
					subscriber(.failure(sessionError))
					return
				}
				
				guard let data = data else {
					subscriber(.failure(.noData))
					return
				}
				
				if let error = error {
					subscriber(.failure(.unknown(error)))
				} else {
					subscriber(.success(data))
				}
			}
			
			task.resume()
		}
	}
}

enum URLSessionError: Error {
    case invalidResponse
    case noData
    case serverErrorMessage(statusCode: Int, data: Data)
    case serverError(statusCode: Int, error: Error?)
    case unknown(Error)
}
