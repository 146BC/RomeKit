import Foundation

public class Bootstrap {
    
    required public init?(baseUrl: URL, apiKey: String) {
        NetworkManager.setup(baseUrl: baseUrl, apiKey: apiKey)
    }
    
    public func start() {
        
    }
    
}
