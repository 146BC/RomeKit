import XCTest

@testable import RomeKit

class AssetModelTests: XCTestCase {
    
    func testModel() {
        
		if let assetJSON = FileHelpers.getJSONDataFrom(name:"asset") {
			
			if let asset = try? JSONDecoder().decode(Asset.self, from: assetJSON) {
                XCTAssertEqual(asset.id, "25f68e7701fc5b12a0d17e32")
                XCTAssertEqual(asset.name, "Alamofire")
                XCTAssertEqual(asset.revision, "3.3.0")
                XCTAssertEqual(asset.fileExtension, "zip")
                XCTAssertEqual(asset.active, true)
                XCTAssertNotNil(asset.createdAt)
                XCTAssertNotNil(asset.updatedAt)
            } else {
                XCTFail("Error mapping JSON to asset object")
            }
            
        } else {
            XCTFail("JSON not loaded");
        }
        
    }
    
    func testModelArray() {
        
        if let assetsJSON = FileHelpers.getJSONDataFrom(name:"assets") {
            
            if let assets = try? JSONDecoder().decode(Array<Asset>.self, from: assetsJSON) {
                XCTAssertEqual(assets[0].id, "25f68e7701fc5b12a0d17e32")
                XCTAssertEqual(assets[0].name, "Alamofire")
                XCTAssertEqual(assets[0].revision, "3.3.0")
                XCTAssertEqual(assets[0].fileExtension, "zip")
                XCTAssertEqual(assets[0].active, true)
                XCTAssertNotNil(assets[0].createdAt)
                XCTAssertNotNil(assets[0].updatedAt)
                
                XCTAssertEqual(assets[1].id, "56f68e7701fc5b12a0d17e25")
                XCTAssertEqual(assets[1].name, "ObjectMapper")
                XCTAssertEqual(assets[1].revision, "1.2.0")
                XCTAssertEqual(assets[1].fileExtension, "zip")
                XCTAssertEqual(assets[1].active, true)
                XCTAssertNotNil(assets[1].createdAt)
                XCTAssertNotNil(assets[1].updatedAt)
            } else {
                XCTFail("Error mapping JSON to assets object array")
            }
            
        } else {
            XCTFail("JSON not loaded");
        }
        
    }
    
}
