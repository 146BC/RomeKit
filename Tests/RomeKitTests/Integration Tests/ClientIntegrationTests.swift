import XCTest
import RomeKit

class ClientIntegrationTests: XCTestCase {
    
    override func setUp() {
        
        Networking.setup()
        super.setUp()
        
    }
    
    func testAddClient() {
        
        let exp = expectation(description: #function)
        
        Clients.create(name: "MacMini", completionHandler: { (client, error) in
            
            if let client = client {
                XCTAssertEqual(client.name, "MacMini")
                XCTAssertNotNil(client.api_key)
                XCTAssertNotNil(client.id)
            } else {
                XCTFail("Error adding client")
            }
            
            exp.fulfill()
        })
        
        waitForExpectations(timeout: 10.0) { error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
        
    }
    
    func testAllClients() {
        
        let exp = expectation(description: #function)
        
        Clients.all { (clients, error) in
            
            if let clients = clients {
                
                XCTAssertTrue(clients.count == 2)
                
                XCTAssertEqual(clients[0].name, "Master")
                XCTAssertNotNil(clients[0].api_key)
                XCTAssertNotNil(clients[0].id)
                
                XCTAssertEqual(clients[1].name, "MacMini")
                XCTAssertNotNil(clients[1].api_key)
                XCTAssertNotNil(clients[1].id)
                
            } else {
                XCTFail("Error fetching clients")
            }
            
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 10.0) { error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
        
    }
    
    func testDeleteClient() {
        
        let exp = expectation(description: #function)
        
        var newClientId = ""
        
        Clients.all { (clients, error) in
            
            if let clients = clients {
                XCTAssertTrue(clients.count == 2)
                newClientId = clients[1].id!
            }
            
            Clients.delete(id: newClientId, completionHandler: { (deleted, error) in
                
                if let deleted = deleted {
                    XCTAssertTrue(deleted)
                    
                    Clients.all { (clients, error) in
                        if let clients = clients {
                            XCTAssertTrue(clients.count == 1)
                        }
                        
                        exp.fulfill()
                    }
                    
                } else {
                    XCTFail("Error deleting client")
                }
                
            })
            
        }
        
        waitForExpectations(timeout: 10.0) { error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
        
    }

}
