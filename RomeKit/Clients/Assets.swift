import Alamofire
import ObjectMapper

public class Assets {
    
    public static func all(
        queue: DispatchQueue? = nil,
        completion: @escaping ([Asset]?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(.Assets, params: [])
        
        NetworkManager.shared().request(url).validate().responseJSON(queue: queue) { json in
            
            switch json.result {
            case .success(let assetsJSON):
                if let assets = Mapper<Asset>().mapArray(JSONObject: assetsJSON) {
                    completion(assets, nil)
                } else {
                    completion(nil, Errors.ErrorMappingAssets)
                }
            case .failure:                
                completion(nil, Errors.errorTypeFromResponse(json.response))
            }
        }
    }
    
    public static func getLatestAssetByRevision(
        name: String,
        revision: String,
        queue: DispatchQueue? = nil,
        completion: @escaping (Asset?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(.Assets, params: [name, revision])
        
        NetworkManager.shared().request(url).validate().responseJSON(queue: queue) { json in
            
            switch json.result {
            case .success(let assetJSON):
                if let asset = Mapper<Asset>().map(JSONObject: assetJSON) {
                    completion(asset, nil)
                } else {
                    completion(nil, Errors.ErrorMappingAsset)
                }
            case .failure:
                completion(nil, Errors.errorTypeFromResponse(json.response))
            }
        }
    }
    
    public static func getAssetById(
        _ id: String,
        queue: DispatchQueue? = nil,
        completion: @escaping (Asset?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(.Assets, params: [id])
        
        NetworkManager.shared().request(url).validate().responseJSON(queue: queue) { json in
            
            switch json.result {
            case .success(let assetJSON):
                if let asset = Mapper<Asset>().map(JSONObject: assetJSON) {
                    completion(asset, nil)
                } else {
                    completion(nil, Errors.ErrorMappingAsset)
                }
            case .failure:
                completion(nil, Errors.errorTypeFromResponse(json.response))
            }
        }
    }
    
    public static func create(
        _ name: String,
        revision: String,
        data: Data,
        queue: DispatchQueue? = nil,
        progress: @escaping (Progress) -> (),
        completion: @escaping (Asset?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(.Assets, params: [])
        let headers = [Headers.ASSET_NAME: name,
                       Headers.ASSET_REVISION: revision,
                       Headers.ASSET_CONTENT_TYPE: Headers.DEFAULT_ASSET_CONTENT_TYPE]

        NetworkManager.shared().upload(data,
                                       to: url,
                                       method: .post,
                                       headers: headers)
        .uploadProgress(closure: progress)
        .validate().responseJSON(queue: queue) { json in

            switch json.result {
            case .success(let assetJSON):
                if let asset = Mapper<Asset>().map(JSONObject: assetJSON) {
                    completion(asset, nil)
                } else {
                    completion(nil, Errors.ErrorMappingAsset)
                }
            case .failure:
                completion(nil, Errors.errorTypeFromResponse(json.response))
            }

        }
    }
    
    public static func delete(
        _ id: String,
        queue: DispatchQueue? = nil,
        completion: @escaping (Bool?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(.Assets, params: [id])
        
        NetworkManager.shared().request(url,
                                        method: .delete,
                                        encoding: URLEncoding.default)
        .validate().responseString(queue: queue) { response in

            switch response.result {
            case .success:
                completion(true, nil)
            case .failure:
                completion(false, Errors.errorTypeFromResponse(response.response))
            }
        }
    }
    
    public static func updateStatus(
        id: String,
        active: Bool,
        queue: DispatchQueue? = nil,
        completion: @escaping (Bool?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(.Assets, params: [id])
        let params = ["active": active]
        
        NetworkManager.shared().request(url,
                                        method: .patch,
                                        parameters: params,
                                        encoding: JSONEncoding.default)
            .validate().responseString(queue: queue) { response in
            
            switch response.result {
            case .success:
                completion(true, nil)
            case .failure:
                completion(false, Errors.errorTypeFromResponse(response.response))
            }
            
        }
        
    }
    
}
