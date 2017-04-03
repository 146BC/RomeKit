import Alamofire
import ObjectMapper

public class Assets {
    
    public static func all(
        _ queue: DispatchQueue? = nil,
        completionHandler: @escaping ([Asset]?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(.Assets, params: [])
        
        NetworkManager.sharedInstance().request(url, method: .get).validate().responseString(queue: queue) { response in
            
            switch response.result {
            case .success(let assetsJSON):
                if let assets = Mapper<Asset>().mapArray(JSONString: assetsJSON) {
                    completionHandler(assets, nil)
                } else {
                    completionHandler(nil, Errors.errorMappingAssets)
                }
            case .failure:
                completionHandler(nil, Errors.errorTypeFromResponse(response.response))
            }
            
        }
        
    }
    
    public static func getLatestAssetByRevision(
        _ name: String,
        revision: String,
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (Asset?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(.Assets, params: [name, revision])
        
        NetworkManager.sharedInstance().request(url, method: .get).validate().responseString(queue: queue) { response in
            
            switch response.result {
            case .success(let assetJSON):
                if let asset = Mapper<Asset>().map(JSONString: assetJSON) {
                    completionHandler(asset, nil)
                } else {
                    completionHandler(nil, Errors.errorMappingAsset)
                }
            case .failure:
                completionHandler(nil, Errors.errorTypeFromResponse(response.response))
            }
            
        }
        
    }
    
    public static func getAssetById(
        _ id: String,
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (Asset?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(.Assets, params: [id])
        
        NetworkManager.sharedInstance().request(url, method: .get).validate().responseString(queue: queue) { response in
            
            switch response.result {
            case .success(let assetJSON):
                if let asset = Mapper<Asset>().map(JSONString: assetJSON) {
                    completionHandler(asset, nil)
                } else {
                    completionHandler(nil, Errors.errorMappingAsset)
                }
            case .failure:
                completionHandler(nil, Errors.errorTypeFromResponse(response.response))
            }
            
        }
        
    }
    
    public static func create(
        _ name: String,
        revision: String,
        data: Data,
        queue: DispatchQueue? = nil,
        progress: @escaping (Int64, Int64) -> (),
        completionHandler: @escaping (Asset?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(.Assets, params: [])
        let headers = [Headers.ASSET_NAME: name, Headers.ASSET_REVISION: revision, Headers.ASSET_CONTENT_TYPE: Headers.DEFAULT_ASSET_CONTENT_TYPE]
        
        NetworkManager.sharedInstance().upload(data, to: url, method: .post, headers: headers).uploadProgress { progressHandler in
                progress(progressHandler.completedUnitCount, progressHandler.totalUnitCount)
            }
            .validate().responseJSON(queue: queue) { response in
                
                switch response.result {
                case .success(let assetJSON):
                    if let asset = Mapper<Asset>().map(JSONObject: assetJSON) {
                        completionHandler(asset, nil)
                    } else {
                        completionHandler(nil, Errors.errorMappingAsset)
                    }
                case .failure:
                    completionHandler(nil, Errors.errorTypeFromResponse(response.response))
                }
                
        }
        
    }
    
    public static func delete(
        _ id: String,
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (Bool?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(.Assets, params: [id])
        
            NetworkManager.sharedInstance().request(url,
                                                    method: .delete,
                                                    parameters: nil,
                                                    encoding: URLEncoding.default,
                                                    headers: nil)
                .validate().responseString(queue: queue) { response in
            switch response.result {
            case .success:
                completionHandler(true, nil)
            case .failure:
                completionHandler(false, Errors.errorTypeFromResponse(response.response))
            }
            
        }
        
    }
    
    public static func updateStatus(
        _ id: String,
        active: Bool,
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (Bool?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(.Assets, params: [id])
        let params = ["active": active]
        
        NetworkManager.sharedInstance().request(url,
                                                method: .patch,
                                                parameters: params,
                                                encoding: JSONEncoding.default,
                                                headers: nil)
            .validate().responseString(queue: queue) { response in
            
            switch response.result {
            case .success:
                completionHandler(true, nil)
            case .failure:
                completionHandler(false, Errors.errorTypeFromResponse(response.response))
            }
            
        }
        
    }
    
}
