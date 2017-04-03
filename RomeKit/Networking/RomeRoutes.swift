public enum RomeRoutes: String {
    
    case Assets
    case Clients
    
    public static func url(_ route: RomeRoutes, params: [String]) -> URL {
        
        var fullUrl = NetworkManager.baseUrl + route.rawValue.lowercased()
        
        for param in params {
            fullUrl = fullUrl + "/\(param)"
        }
        
        return URL(string: fullUrl)!
        
    }
    
}
