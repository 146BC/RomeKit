import Foundation
import Alamofire

class NetworkManager {
    private(set) static var baseUrl: String = String()
    
    static var configuration = URLSessionConfiguration.default
    static var serverTrustPolicies = [String: ServerTrustPolicy]()
    
    private static var _sharedInstance: SessionManager?
    
    static var additionalHeaders: [AnyHashable : Any]? {
        didSet {
            if let _ = additionalHeaders {
                configuration.httpAdditionalHeaders = additionalHeaders
            } else {
                configuration.httpAdditionalHeaders = nil
            }
            _sharedInstance = SessionManager(configuration: configuration, serverTrustPolicyManager: ServerTrustPolicyManager(policies:serverTrustPolicies))
        }
    }
    
    static var sharedInstance: SessionManager {
        if _sharedInstance == nil {
            _sharedInstance = SessionManager(configuration: configuration, serverTrustPolicyManager: ServerTrustPolicyManager(policies:serverTrustPolicies))
        }
        return _sharedInstance!
        
    }
    
    static func setup(baseUrl: String, apiKey: String) {
        
        NetworkManager.additionalHeaders = [Headers.API_KEY : apiKey]
        self.baseUrl = baseUrl
        
    }
    
}
