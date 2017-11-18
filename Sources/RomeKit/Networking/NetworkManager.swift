import Foundation

class NetworkManager {
	
	static let shared = NetworkManager()
	
    private(set) var baseUrl: String = String()
    private let configuration = URLSessionConfiguration.default
	
	func setup(baseUrl: String, apiKey: String) {
        NetworkManager.shared.configuration.httpAdditionalHeaders = [Headers.API_KEY : apiKey]
        NetworkManager.shared.baseUrl = baseUrl
    }
	
	func session() -> URLSession {
		return URLSession(configuration: NetworkManager.shared.configuration)
	}
}
