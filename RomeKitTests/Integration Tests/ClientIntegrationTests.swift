import XCTest
import RomeKit

class ClientIntegrationTests: XCTestCase {
    
    override func setUp() {
        
        Networking.setup()
        super.setUp()
        
    }
    
    func testAddClient() {
        
        let addExpectation = expectation(description: #function)
        
        Clients.create("MacMini", completion: { (client, error) in
            
            if let client = client {
                XCTAssertEqual(client.name, "MacMini")
                XCTAssertNotNil(client.api_key)
                XCTAssertNotNil(client.id)
            } else {
                XCTFail("Error adding client")
            }
            
            addExpectation.fulfill()
        })

        waitForExpectations(timeout: 10.0) { error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
        
    }
    
    func testAllClients() {
        
        let allClientsExpectation = expectation(description: #function)
        
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
            
            allClientsExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0) { error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
        
    }
    
    func testDeleteClient() {
        
        let deleteExpectation = expectation(description: #function)
        
        var newClientId = ""
        
        Clients.all { (clients, error) in
            
            if let clients = clients {
                XCTAssertTrue(clients.count == 2)
                newClientId = clients[1].id!
            }
            
            Clients.delete(newClientId, completion: { (deleted, error) in
                
                if let deleted = deleted {
                    XCTAssertTrue(deleted)
                    
                    Clients.all { (clients, error) in
                        if let clients = clients {
                            XCTAssertTrue(clients.count == 1)
                        }
                        
                        deleteExpectation.fulfill()
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
