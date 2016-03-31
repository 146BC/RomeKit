public class Bootstrap {
    
    required public init?(baseUrl: String, apiKey: String) {
        NetworkManager.setup(baseUrl, apiKey: apiKey)
    }
    
    public func start() {
        
    }
    
}