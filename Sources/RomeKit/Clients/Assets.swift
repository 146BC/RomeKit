import Alamofire
import Foundation
import ObjectMapper
import Dispatch

public class Assets {
    
    public static func all(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping ([Asset]?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(route: .assets, params: [])
        
        NetworkManager.sharedInstance.request(url, method: .get).validate().responseString(queue: queue) { response in
            switch response.result {
            case .success(let assetsJSON):
                if let assets = Mapper<Asset>().mapArray(JSONString: assetsJSON) {
                    completionHandler(assets, nil)
                } else {
                    completionHandler(nil, Errors.ErrorMappingAssets)
                }
            case .failure:
                completionHandler(nil, Errors.errorTypeFromResponse(response: response.response))
            }
        }
    }
    
    public static func getLatestAssetByRevision(
        name: String,
        revision: String,
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (Asset?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(route: .assets, params: [name, revision])
        
        NetworkManager.sharedInstance.request(url, method: .get).validate().responseString(queue: queue) { response in
            switch response.result {
            case .success(let assetJSON):
                if let asset = Mapper<Asset>().map(JSONString: assetJSON) {
                    completionHandler(asset, nil)
                } else {
                    completionHandler(nil, Errors.ErrorMappingAsset)
                }
            case .failure:
                completionHandler(nil, Errors.errorTypeFromResponse(response: response.response))
            }
        }
    }
    
    public static func getAssetById(
        id: String,
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (Asset?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(route: .assets, params: [id])
        
        NetworkManager.sharedInstance.request(url, method: .get).validate().responseString(queue: queue) { response in
            switch response.result {
            case .success(let assetJSON):
                if let asset = Mapper<Asset>().map(JSONString: assetJSON) {
                    completionHandler(asset, nil)
                } else {
                    completionHandler(nil, Errors.ErrorMappingAsset)
                }
            case .failure:
                completionHandler(nil, Errors.errorTypeFromResponse(response: response.response))
            }
        }
    }
    
    public static func create(
        name: String,
        revision: String,
        data: Data,
        queue: DispatchQueue? = nil,
        progress: @escaping (Int64, Int64) -> (),
        completionHandler: @escaping (Asset?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(route: .assets, params: [])
        let headers = [Headers.ASSET_NAME: name, Headers.ASSET_REVISION: revision, Headers.ASSET_CONTENT_TYPE: Headers.DEFAULT_ASSET_CONTENT_TYPE]
        
        NetworkManager.sharedInstance.upload(data, to: url, method: .post, headers: headers).uploadProgress(queue: queue ?? DispatchQueue.main) { prg in
                progress(prg.completedUnitCount, prg.totalUnitCount)
            }
            .validate().responseJSON(queue: queue) { response in
                switch response.result {
                case .success(let assetJSON):
                    if let asset = Mapper<Asset>().map(JSONObject: assetJSON) {
                        completionHandler(asset, nil)
                    } else {
                        completionHandler(nil, Errors.ErrorMappingAsset)
                    }
                case .failure:
                    completionHandler(nil, Errors.errorTypeFromResponse(response: response.response))
                }
        }
    }
    
    public static func delete(
        id: String,
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (Bool?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(route: .assets, params: [id])
        
        NetworkManager.sharedInstance.request(url, method: .delete).validate().responseString(queue: queue) { response in
            switch response.result {
            case .success:
                completionHandler(true, nil)
            case .failure:
                completionHandler(false, Errors.errorTypeFromResponse(response: response.response))
            }
            
        }
        
    }
    
    public static func updateStatus(
        id: String,
        active: Bool,
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (Bool?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(route: .assets, params: [id])
        let params = ["active": active]
        
        NetworkManager.sharedInstance.request(url, method: .patch, parameters: params, encoding: JSONEncoding.default).validate().responseString(queue: queue) { response in
            switch response.result {
            case .success:
                completionHandler(true, nil)
            case .failure:
                completionHandler(false, Errors.errorTypeFromResponse(response: response.response))
            }
            
        }
        
    }
    
}
