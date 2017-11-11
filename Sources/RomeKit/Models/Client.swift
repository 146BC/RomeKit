public struct Client: Codable {
    public let id: String?
    public let name: String?
    public let apiKey: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case apiKey = "api_key"
    }
    
	public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        apiKey = try values.decode(String.self, forKey: .apiKey)
    }
}
