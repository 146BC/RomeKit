import Foundation

public enum Errors: Error {
    
    // Clients
    case errorMappingClient
    case errorMappingClients
    
    // Assets
    case errorMappingAsset
    case errorMappingAssets
    
    // HTTP
    case entityNotFound
    case badRequest
    case serviceError
    
    public static func errorTypeFromResponse(_ response: HTTPURLResponse?) -> Errors {
        
        if let response = response {
            switch response.statusCode {
            case 404: return .entityNotFound
            case 400: return .badRequest
            default: return .serviceError
            }
        } else {
            return .serviceError
        }
        
    }
}
