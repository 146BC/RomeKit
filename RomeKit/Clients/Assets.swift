import Alamofire
import ObjectMapper

public class Assets {
    
    public static func all(
        queue: dispatch_queue_t? = nil,
        completionHandler: ([Asset]?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(.Assets, params: [])
        
        NetworkManager.sharedInstance().request(.GET, url).validate().responseString(queue: queue) { response in
            
            switch response.result {
            case .Success(let assetsJSON):
                if let assets = Mapper<Asset>().mapArray(assetsJSON) {
                    completionHandler(assets, nil)
                } else {
                    completionHandler(nil, Errors.ErrorMappingAssets)
                }
            case .Failure:
                completionHandler(nil, Errors.errorTypeFromResponse(response.response))
            }
            
        }
        
    }
    
    public static func getLatestAssetByRevision(
        name: String,
        revision: String,
        queue: dispatch_queue_t? = nil,
        completionHandler: (Asset?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(.Assets, params: [name, revision])
        
        NetworkManager.sharedInstance().request(.GET, url).validate().responseString(queue: queue) { response in
            
            switch response.result {
            case .Success(let assetJSON):
                if let asset = Mapper<Asset>().map(assetJSON) {
                    completionHandler(asset, nil)
                } else {
                    completionHandler(nil, Errors.ErrorMappingAsset)
                }
            case .Failure:
                completionHandler(nil, Errors.errorTypeFromResponse(response.response))
            }
            
        }
        
    }
    
    public static func getAssetById(
        id: String,
        queue: dispatch_queue_t? = nil,
        completionHandler: (Asset?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(.Assets, params: [id])
        
        NetworkManager.sharedInstance().request(.GET, url).validate().responseString(queue: queue) { response in
            
            switch response.result {
            case .Success(let assetJSON):
                if let asset = Mapper<Asset>().map(assetJSON) {
                    completionHandler(asset, nil)
                } else {
                    completionHandler(nil, Errors.ErrorMappingAsset)
                }
            case .Failure:
                completionHandler(nil, Errors.errorTypeFromResponse(response.response))
            }
            
        }
        
    }
    
    public static func create(
        name: String,
        revision: String,
        data: NSData,
        queue: dispatch_queue_t? = nil,
        progress: (Int64, Int64, Int64) -> (),
        completionHandler: (Asset?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(.Assets, params: [])
        let headers = [Headers.ASSET_NAME: name, Headers.ASSET_REVISION: revision, Headers.ASSET_CONTENT_TYPE: Headers.DEFAULT_ASSET_CONTENT_TYPE]
        
        NetworkManager.sharedInstance().upload(.POST, url, headers: headers, data: data).progress { bytesWritten, totalBytesWritten, totalBytesExpectedToWrite in
            
            dispatch_async(dispatch_get_main_queue()) {
                progress(bytesWritten, totalBytesWritten, totalBytesExpectedToWrite)
            }
            
            }
            .validate().responseJSON(queue: queue) { response in
                
                switch response.result {
                case .Success(let assetJSON):
                    if let asset = Mapper<Asset>().map(assetJSON) {
                        completionHandler(asset, nil)
                    } else {
                        completionHandler(nil, Errors.ErrorMappingAsset)
                    }
                case .Failure:
                    completionHandler(nil, Errors.errorTypeFromResponse(response.response))
                }
                
        }
        
    }
    
    public static func delete(
        id: String,
        queue: dispatch_queue_t? = nil,
        completionHandler: (Bool?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(.Assets, params: [id])
        
        NetworkManager.sharedInstance().request(.DELETE, url, parameters: nil, encoding: .URL, headers: nil).validate().responseString(queue: queue) { response in
            
            switch response.result {
            case .Success:
                completionHandler(true, nil)
            case .Failure:
                completionHandler(false, Errors.errorTypeFromResponse(response.response))
            }
            
        }
        
    }
    
    public static func updateStatus(
        id: String,
        active: Bool,
        queue: dispatch_queue_t? = nil,
        completionHandler: (Bool?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(.Assets, params: [id])
        let params = ["active": active]
        
        NetworkManager.sharedInstance().request(.PATCH, url, parameters: params, encoding: .JSON, headers: nil).validate().responseString(queue: queue) { response in
            
            switch response.result {
            case .Success:
                completionHandler(true, nil)
            case .Failure:
                completionHandler(false, Errors.errorTypeFromResponse(response.response))
            }
            
        }
        
    }
    
}