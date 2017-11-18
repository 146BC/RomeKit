import RomeKit

class Networking {
    
    // Headers
    static let URL = "http://localhost:3000/"
    static let API_KEY = "fbdc5668-c02f-456d-9e8f-6d02fb8ef490"
    
    static func setup() {
        
        if let bootstrap = RomeKit.Bootstrap(baseUrl: self.URL, apiKey: self.API_KEY) {
            bootstrap.start()
        }
        
    }
    
}
