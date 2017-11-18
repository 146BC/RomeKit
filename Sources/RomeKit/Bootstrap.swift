public class Bootstrap {
    
    required public init?(baseUrl: String, apiKey: String) {
        NetworkManager.shared.setup(baseUrl: baseUrl, apiKey: apiKey)
    }
    
    public func start() {
        
    }
    
}
