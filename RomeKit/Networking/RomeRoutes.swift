public enum RomeRoutes: String {
    
    case Assets
    case Clients
    
    public static func url(route: RomeRoutes, params: [String]) -> NSURL {
        
        var fullUrl = NetworkManager.baseUrl + route.rawValue.lowercaseString
        
        for param in params {
            fullUrl = fullUrl.stringByAppendingString("/\(param)")
        }
        
        return NSURL(string: fullUrl)!
        
    }
    
}