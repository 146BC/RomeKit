import Foundation

class NetworkManager {
    private(set) static var baseUrl: String = String()
    
    static var configuration = URLSessionConfiguration.default
    
    static func setup(baseUrl: String, apiKey: String) {
        URLSession.shared.configuration.httpAdditionalHeaders = [Headers.API_KEY : apiKey]
        self.baseUrl = baseUrl
    }
    
}
