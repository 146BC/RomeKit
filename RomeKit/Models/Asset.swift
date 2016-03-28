import ObjectMapper

public class Asset: Mappable {
    
    var id: String?
    var name: String?
    var revision: String?
    var file_extension: String?
    var active: Bool?
    var created_at: NSDate?
    var updated_at: NSDate?
    
    required public init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        
        id              <- map["_id"]
        name            <- map["name"]
        revision        <- map["revision"]
        file_extension  <- map["extension"]
        active          <- map["active"]
        created_at      <- (map["createdAt"], ISO8601MilliSecondsDateTransform())
        updated_at      <- (map["updatedAt"], ISO8601MilliSecondsDateTransform())
        
    }
    
}