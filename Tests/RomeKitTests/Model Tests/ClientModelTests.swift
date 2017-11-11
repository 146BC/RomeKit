import XCTest

@testable import RomeKit

class ClientModelTests: XCTestCase {

    func testModel() {
		
		if let clientJSON = FileHelpers.getJSONDataFrom(name:"client") {
			
			if let client = try? JSONDecoder().decode(Client.self, from: clientJSON) {
				XCTAssertEqual(client.id, "56f68a12a3de01599f17224a")
				XCTAssertEqual(client.apiKey, "fbdc5668-c02f-456d-9e8f-6d02fb8ef490")
				XCTAssertEqual(client.name, "Master")
			} else {
				XCTFail("Error mapping JSON to client object")
			}
			
		} else {
			XCTFail("JSON not loaded");
		}
        
    }
    
    func testModelArray() {
        
		if let clientsJSON = FileHelpers.getJSONDataFrom(name:"clients") {
			
			if let clients = try? JSONDecoder().decode(Array<Client>.self, from: clientsJSON) {
                XCTAssertEqual(clients[0].id, "56f68a12a3de01599f17224a")
                XCTAssertEqual(clients[0].apiKey, "fbdc5668-c02f-456d-9e8f-6d02fb8ef490")
                XCTAssertEqual(clients[0].name, "Master")
                
                XCTAssertEqual(clients[1].id, "88f68b15a3de01599f17275a")
                XCTAssertEqual(clients[1].apiKey, "bhsc5654-c02f-456d-9e8f-6d02fb8de492")
                XCTAssertEqual(clients[1].name, "Mac Mini")
            } else {
                XCTFail("Error mapping JSON to clients object array")
            }
            
        } else {
            XCTFail("JSON not loaded");
        }
        
    }
    
}
