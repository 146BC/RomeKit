import Alamofire
import ObjectMapper

public class Assets {
    
    public static func all(
        completionHandler: ([Asset]?, Errors?) -> ()) {
                
    }
    
    public static func getLatestAssetByRevision(
        name: String,
        revision: String,
        completionHandler: (Asset?, Errors?) -> ()) {
        
    }
    
    public static func getAssetById(
        id: String,
        completionHandler: (Asset?, Errors?) -> ()) {
        
    }
    
    public static func create(
        id: String,
        completionHandler: (Asset?, Errors?) -> ()) {
        
    }
    
    public static func delete(
        id: String,
        completionHandler: (Bool?, Errors?) -> ()) {
        
    }
    
    public static func updateStatus(
        id: String,
        enabled: Bool,
        completionHandler: (Bool?, Errors?) -> ()) {
        
    }
    
}