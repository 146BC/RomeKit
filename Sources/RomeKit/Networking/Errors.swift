import Foundation

public enum Errors: Error {
    
    // Clients
    case ErrorMappingClient
    case ErrorMappingClients
    
    // Assets
    case ErrorMappingAsset
    case ErrorMappingAssets
    
    // HTTP
    case EntityNotFound
    case BadRequest
    case ServiceError
    
    public static func errorTypeFromResponse(_ response: HTTPURLResponse?) -> Errors {
        
        if let response = response {
            switch response.statusCode {
            case 404: return .EntityNotFound
            case 400: return .BadRequest
            default: return .ServiceError
            }
        } else {
            return .ServiceError
        }
        
    }
}
