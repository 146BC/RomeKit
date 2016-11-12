import Foundation
import Alamofire

public class NetworkManager {

    public static var additionalHeaders: [AnyHashable : Any]? {
        didSet {
            configuration.httpAdditionalHeaders = additionalHeaders
            _shared = self.shared()
        }
    }

    public static var configuration = URLSessionConfiguration.default
    public static var serverTrustPolicies = [String: ServerTrustPolicy]()
    public static var baseUrl: URL?

    private static var _shared: SessionManager?

    public static func shared() -> SessionManager {
        if _shared == nil {
            _shared = SessionManager(configuration: configuration, serverTrustPolicyManager: ServerTrustPolicyManager(policies:serverTrustPolicies))
        }
        return _shared!
    }

    public static func setup(baseUrl: URL, apiKey: String) {

        NetworkManager.additionalHeaders = [Headers.API_KEY : apiKey]
        self.baseUrl = baseUrl

    }

    public static func clearCache() {
        URLCache.shared.removeAllCachedResponses()
    }

}
