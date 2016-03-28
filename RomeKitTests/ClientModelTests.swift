import XCTest
import ObjectMapper

@testable import RomeKit

class ClientModelTests: XCTestCase {

    func testModel() {
        
        if let clientJSON = FileHelpers.loadJSONStringFromFile("client") {
            
            if let client = Mapper<Client>().map(clientJSON) {
                
                XCTAssertEqual(client.id, "56f68a12a3de01599f17224a")
                XCTAssertEqual(client.api_key, "fbdc5668-c02f-456d-9e8f-6d02fb8ef490")
                XCTAssertEqual(client.name, "Master")
                
            } else {
                XCTFail("Error mapping JSON to client object")
            }
            
        } else {
            XCTFail("JSON not loaded");
        }
        
    }
    
    func testModelArray() {
        
        if let clientsJSON = FileHelpers.loadJSONStringFromFile("clients") {
            
            if let clients = Mapper<Client>().mapArray(clientsJSON) {
                
                XCTAssertEqual(clients[0].id, "56f68a12a3de01599f17224a")
                XCTAssertEqual(clients[0].api_key, "fbdc5668-c02f-456d-9e8f-6d02fb8ef490")
                XCTAssertEqual(clients[0].name, "Master")
                
                XCTAssertEqual(clients[1].id, "88f68b15a3de01599f17275a")
                XCTAssertEqual(clients[1].api_key, "bhsc5654-c02f-456d-9e8f-6d02fb8de492")
                XCTAssertEqual(clients[1].name, "Mac Mini")
                
            } else {
                XCTFail("Error mapping JSON to clients object array")
            }
            
        } else {
            XCTFail("JSON not loaded");
        }
        
    }
    
}
