import Foundation
import Alamofire

class NetworkManager {
    
    private(set) static var baseUrl: String = String()
    
    static var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
    static var serverTrustPolicies = [String: ServerTrustPolicy]()
    
    private static var _sharedInstance: Manager?
    
    static var additionalHeaders: [NSObject : AnyObject]? {
        
        didSet {
            if let _ = additionalHeaders {
                configuration.HTTPAdditionalHeaders = additionalHeaders
            } else {
                configuration.HTTPAdditionalHeaders = nil
            }
            _sharedInstance = Manager(configuration: configuration, serverTrustPolicyManager: ServerTrustPolicyManager(policies:serverTrustPolicies))
        }
        
    }
    
    static func sharedInstance() -> Manager {
        
        if _sharedInstance == nil {
            _sharedInstance = Manager(configuration: configuration, serverTrustPolicyManager: ServerTrustPolicyManager(policies:serverTrustPolicies))
        }
        return _sharedInstance!
        
    }
    
    static func setup(baseUrl: String, apiKey: String) {
        
        NetworkManager.additionalHeaders = [Headers.API_KEY : apiKey]
        self.baseUrl = baseUrl
        
    }
    
}