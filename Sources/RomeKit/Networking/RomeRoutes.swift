import Foundation

public enum RomeRoutes: String {
    case assets
    case clients
    
    public static func url(route: RomeRoutes, params: [String]) -> URL {
        var fullUrl = NetworkManager.baseUrl + route.rawValue
        
        for param in params {
            fullUrl = fullUrl.appending("/\(param)")
        }
        
        return URL(string: fullUrl)!
    }
    
}
