import ObjectMapper

public class Asset: Mappable {
    
    public var id: String?
    public var name: String?
    public var revision: String?
    public var file_extension: String?
    public var active: Bool?
    public var created_at: NSDate?
    public var updated_at: NSDate?
    
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