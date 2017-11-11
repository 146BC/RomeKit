import Foundation

public struct Asset: Codable {
    public let id: String?
    public let name: String?
    public let revision: String?
    public let fileExtension: String?
    public let active: Bool?
    public let createdAt: Date?
    public let updatedAt: Date?
	
	enum CodingKeys: String, CodingKey {
		case id = "_id"
		case name
		case revision
		case fileExtension = "extension"
		case active
		case createdAt
		case updatedAt
	}
	
	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decode(String.self, forKey: .id)
		name = try values.decode(String.self, forKey: .name)
		revision = try values.decode(String.self, forKey: .revision)
		fileExtension = try values.decode(String.self, forKey: .fileExtension)
		active = try values.decode(Bool.self, forKey: .active)
		
		let createdAtString = try values.decode(String.self, forKey: .createdAt)
		let updatedAtString = try values.decode(String.self, forKey: .updatedAt)
		//dateOfBirth = Date(timeIntervalSince1970: dateOfBirthMilliseconds / 1000)
		createdAt = Date.fromISO8601(createdAtString)
		updatedAt = Date.fromISO8601(updatedAtString)
	}
}
