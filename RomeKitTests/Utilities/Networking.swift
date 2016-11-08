import RomeKit

class Networking {
    
    // Headers
    static let url = URL(string: "http://localhost:3000/")!
    static let apiKey = "fbdc5668-c02f-456d-9e8f-6d02fb8ef490"
    
    static func setup() {
        
        if let bootstrap = RomeKit.Bootstrap(baseUrl: self.url, apiKey: self.apiKey) {
            bootstrap.start()
        }
        
    }
    
}
