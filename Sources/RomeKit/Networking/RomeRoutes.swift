import Foundation

public enum RomeRoutes: String {
    
    case Assets
    case Clients
    
    public static func url(_ route: RomeRoutes, params: [String]) -> URL {
        let baseUrl = NetworkManager.baseUrl?.absoluteString ?? ""
        var fullUrl = baseUrl + route.rawValue.lowercased()
        
        for param in params {
            fullUrl = fullUrl.appending("/\(param)")
        }
        
        return URL(string: fullUrl)!
        
    }
    
}
