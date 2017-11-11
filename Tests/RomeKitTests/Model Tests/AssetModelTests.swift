import XCTest
import ObjectMapper

@testable import RomeKit

class AssetModelTests: XCTestCase {
    
    func testModel() {
        
        if let assetJSON = FileHelpers.loadJSONStringFromFile("asset") {
            
            if let asset = Mapper<Asset>().map(JSONString: assetJSON) {
                
                XCTAssertEqual(asset.id, "25f68e7701fc5b12a0d17e32")
                XCTAssertEqual(asset.name, "Alamofire")
                XCTAssertEqual(asset.revision, "3.3.0")
                XCTAssertEqual(asset.file_extension, "zip")
                XCTAssertEqual(asset.active, true)
                XCTAssertNotNil(asset.created_at)
                XCTAssertNotNil(asset.updated_at)
                
            } else {
                XCTFail("Error mapping JSON to asset object")
            }
            
        } else {
            XCTFail("JSON not loaded");
        }
        
    }
    
    func testModelArray() {
        
        if let assetsJSON = FileHelpers.loadJSONStringFromFile("assets") {
            
            if let assets = Mapper<Asset>().mapArray(JSONString: assetsJSON) {
                
                XCTAssertEqual(assets[0].id, "25f68e7701fc5b12a0d17e32")
                XCTAssertEqual(assets[0].name, "Alamofire")
                XCTAssertEqual(assets[0].revision, "3.3.0")
                XCTAssertEqual(assets[0].file_extension, "zip")
                XCTAssertEqual(assets[0].active, true)
                XCTAssertNotNil(assets[0].created_at)
                XCTAssertNotNil(assets[0].updated_at)
                
                XCTAssertEqual(assets[1].id, "56f68e7701fc5b12a0d17e25")
                XCTAssertEqual(assets[1].name, "ObjectMapper")
                XCTAssertEqual(assets[1].revision, "1.2.0")
                XCTAssertEqual(assets[1].file_extension, "zip")
                XCTAssertEqual(assets[1].active, true)
                XCTAssertNotNil(assets[1].created_at)
                XCTAssertNotNil(assets[1].updated_at)
                
            } else {
                XCTFail("Error mapping JSON to assets object array")
            }
            
        } else {
            XCTFail("JSON not loaded");
        }
        
    }
    
}
