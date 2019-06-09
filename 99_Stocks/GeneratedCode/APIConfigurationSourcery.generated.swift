// Generated using Sourcery 0.16.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



import Foundation
import Combine

// MARK: - Company.Network.Endpoint

internal extension Company.Network.Endpoint {

	var baseURL: URLConvertible {
		return "https://mobile.ninetynine.com/testapi/1/companies"
	}

	var method: HTTPMethod {
		switch self {
		case .companies:
			return .get
		case .company:
			return .get
		}
	}

	var path: String {
		switch self {
		case .companies:
			return "/"
		case .company(let id):
			return "/\(id)"
		}
	}

	var queryItems: [URLQueryItem] {
		switch self {
		case .companies:
			return []
		case .company:
			return []
		}
	}

	var bodyParameters: [String : Any]? {
		switch self {
			case .companies: return nil
			case .company: return nil
		}
	}
}

// MARK: [API Client] protocol and extension

// By creating this protocol, we could create a mock APIClient (or just another api client in general) that implements
// these methods
protocol CompanyNetworkApiClientProtocol {
	static func companies() -> AnyPublisher<[Company.Model.ItemListResponse], Error>
	static func company(id: Int) -> AnyPublisher<Company.Model.DetailItemResponse, Error>
}

extension Company.Network.ApiClient: CompanyNetworkApiClientProtocol {
	static func companies() -> AnyPublisher<[Company.Model.ItemListResponse], Error> {
		return self.request(.companies)
	}
	static func company(id: Int) -> AnyPublisher<Company.Model.DetailItemResponse, Error> {
		return self.request(.company(id: id))
	}
}
