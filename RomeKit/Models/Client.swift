import ObjectMapper

public class Client: Mappable {
    
    var id: String?
    var name: String?
    var api_key: String?
    
    required public init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        
        id      <- map["_id"]
        name    <- map["name"]
        api_key <- map["api_key"]
        
    }
    
}