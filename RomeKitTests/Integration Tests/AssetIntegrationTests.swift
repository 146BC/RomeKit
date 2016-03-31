import XCTest
import RomeKit

class AssetIntegrationTests: XCTestCase {
    
    override func setUp() {
        
        Networking.setup()
        super.setUp()
        
    }
    
    func testAddAsset() {
        
        let expectation = expectationWithDescription(#function)
        
        let name = "Sample"
        let revision = "1.0"
        
        if let sampleAsset = FileHelpers.loadZipDataFromFile("sample") {
            
            Assets.create(name, revision: revision, data: sampleAsset, progress: { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
                
                    XCTAssertTrue(totalBytesExpectedToWrite > 0)
                
                }, completionHandler: { (asset, error) in
                    
                    if let asset = asset {
                        
                        XCTAssertEqual(asset.name, "Sample")
                        XCTAssertEqual(asset.file_extension, "zip")
                        XCTAssertEqual(asset.revision, "1.0")
                        XCTAssertEqual(asset.active, true)
                        XCTAssertNotNil(asset.id)
                        XCTAssertNotNil(asset.created_at)
                        XCTAssertNotNil(asset.updated_at)
                        
                    } else {
                        XCTFail("Error adding client")
                    }
                    
                    expectation.fulfill()
            })
            
        } else {
            XCTFail("Error loading sample data from zip")
        }
        
        waitForExpectationsWithTimeout(10.0) { error in
            
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
            
        }
        
    }
    
    func testAllAssets() {
        
        let expectation = expectationWithDescription(#function)
        
        Assets.all { (assets, error) in
            
            if let assets = assets {
                
                XCTAssertTrue(assets.count == 1)
                
                XCTAssertEqual(assets[0].name, "Sample")
                XCTAssertEqual(assets[0].file_extension, "zip")
                XCTAssertEqual(assets[0].revision, "1.0")
                XCTAssertEqual(assets[0].active, true)
                XCTAssertNotNil(assets[0].id)
                XCTAssertNotNil(assets[0].created_at)
                XCTAssertNotNil(assets[0].updated_at)
                
            } else {
                XCTFail("Error fetching assets")
            }
            
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10.0) { error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
        
    }
    
    func testLatestAssetFromRevision() {
        
        let expectation = expectationWithDescription(#function)
        
        let name = "Sample"
        let revision = "1.0"
        
        if let sampleAsset = FileHelpers.loadZipDataFromFile("sample") {
            
            Assets.create(name, revision: revision, data: sampleAsset, progress: {_,_,_ in }, completionHandler: { (asset, error) in
                    
                    if let asset = asset {
                        
                        XCTAssertEqual(asset.name, name)
                        XCTAssertEqual(asset.revision, revision)
                        
                        if let assetId = asset.id {
                            Assets.getLatestAssetByRevision(name, revision: revision, completionHandler: { (asset, error) in
                                if let asset = asset {
                                    XCTAssertEqual(asset.id, assetId)
                                } else {
                                    XCTFail("Error fetching asset by revision")
                                }
                                expectation.fulfill()
                            })
                        } else {
                            XCTFail("Error fetching asset id")
                        }
                        
                    } else {
                        XCTFail("Error adding client")
                    }
            })
            
        } else {
            XCTFail("Error loading sample data from zip")
        }
        
        waitForExpectationsWithTimeout(10.0) { error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }

    }
    
    func testAssetInactive() {
        
        let expectation = expectationWithDescription(#function)
        
        let name = "Sample"
        let revision = "1.0"
        
        if let sampleAsset = FileHelpers.loadZipDataFromFile("sample") {
            
            Assets.create(name, revision: revision, data: sampleAsset, progress: {_,_,_ in }, completionHandler: { (asset, error) in
                
                if let asset = asset {
                    
                    XCTAssertEqual(asset.name, name)
                    XCTAssertEqual(asset.revision, revision)
                    
                    if let assetId = asset.id {
                        
                        Assets.updateStatus(assetId, active: false, completionHandler: { (updated, error) in
                            
                            if updated != nil && updated! {
                                Assets.getLatestAssetByRevision(name, revision: revision, completionHandler: { (asset, error) in
                                    
                                    if let asset = asset {
                                        XCTAssertNotEqual(asset.id, assetId)
                                    } else {
                                        XCTFail("Error fetching asset by revision")
                                    }
                                    expectation.fulfill()
                                    
                                })
                            } else {
                                XCTFail("Error updating status")
                            }
                            
                        })
                        
                    } else {
                        XCTFail("Error fetching asset id")
                    }
                    
                } else {
                    XCTFail("Error adding client")
                }
            })
            
        } else {
            XCTFail("Error loading sample data from zip")
        }
        
        waitForExpectationsWithTimeout(10.0) { error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
        
    }
    
    func testAssetById() {
        
        let expectation = expectationWithDescription(#function)
        
        let name = "Sample"
        let revision = "1.0"
        
        if let sampleAsset = FileHelpers.loadZipDataFromFile("sample") {
            
            Assets.create(name, revision: revision, data: sampleAsset, progress: {_,_,_ in }, completionHandler: { (asset, error) in
                
                if let asset = asset {
                    
                    XCTAssertEqual(asset.name, name)
                    XCTAssertEqual(asset.revision, revision)
                    
                    if let assetId = asset.id {
                        
                        Assets.getAssetById(assetId, completionHandler: { (asset, error) in
                            if let asset = asset {
                                XCTAssertEqual(asset.id, assetId)
                            } else {
                                XCTFail("Error fetching asset by revision")
                            }
                            expectation.fulfill()
                        })
                        
                    } else {
                        XCTFail("Error fetching asset id")
                    }
                    
                } else {
                    XCTFail("Error adding client")
                }
            })
            
        } else {
            XCTFail("Error loading sample data from zip")
        }
        
        waitForExpectationsWithTimeout(10.0) { error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
        
    }
    
    func testDeleteAsset() {
        
        let expectation = expectationWithDescription(#function)
        
        let name = "Sample"
        let revision = "1.0"
        
        if let sampleAsset = FileHelpers.loadZipDataFromFile("sample") {
            
            Assets.create(name, revision: revision, data: sampleAsset, progress: {_,_,_ in }, completionHandler: { (asset, error) in
                
                if let asset = asset {
                    
                    XCTAssertEqual(asset.name, name)
                    XCTAssertEqual(asset.revision, revision)
                    
                    if let assetId = asset.id {
                        
                        Assets.delete(assetId, completionHandler: { (deleted, error) in
                            
                            if deleted != nil && deleted! {
                                Assets.getAssetById(assetId, completionHandler: { (asset, error) in
                                    XCTAssertEqual(error, Errors.EntityNotFound)
                                    expectation.fulfill()
                                })
                            } else {
                                XCTFail("Error deleting asset")
                            }
                            
                        })
                        
                    } else {
                        XCTFail("Error fetching asset id")
                    }
                    
                } else {
                    XCTFail("Error adding client")
                }
            })
            
        } else {
            XCTFail("Error loading sample data from zip")
        }
        
        waitForExpectationsWithTimeout(10.0) { error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
        
    }
    
}
