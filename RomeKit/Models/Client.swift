import ObjectMapper

public class Client: Mappable {
    
    public var id: String?
    public var name: String?
    public var api_key: String?
    
    required public init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        
        id      <- map["_id"]
        name    <- map["name"]
        api_key <- map["api_key"]
        
    }
    
}
