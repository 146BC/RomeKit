import Alamofire
import ObjectMapper

public class Clients {
    
    public static func all(
        _ queue: DispatchQueue? = nil,
        completionHandler: @escaping ([Client]?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(.Clients, params: [])
        
        NetworkManager.sharedInstance().request(url, method: .get).responseString(queue: queue) { response in
            
            switch response.result {
            case .success(let clientsJSON):
                if let clients = Mapper<Client>().mapArray(JSONString: clientsJSON) {
                    completionHandler(clients, nil)
                } else {
                    completionHandler(nil, Errors.errorMappingClients)
                }
            case .failure:
                completionHandler(nil, Errors.errorTypeFromResponse(response.response))
            }
            
        }
        
    }
    
    public static func create(
        _ name: String,
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (Client?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(.Clients, params: [])
        let params = ["name": name]
        
        NetworkManager.sharedInstance().request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseString(queue: queue) { response in
            
            switch response.result {
            case .success(let clientJSON):
                if let client = Mapper<Client>().map(JSONString: clientJSON) {
                    completionHandler(client, nil)
                } else {
                    completionHandler(nil, Errors.errorMappingClients)
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
        
        let url = RomeRoutes.url(.Clients, params: [id])
        
        NetworkManager.sharedInstance().request(url, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseString(queue: queue) { response in
            switch response.result {
            case .success:
                completionHandler(true, nil)
            case .failure:
                completionHandler(false, Errors.errorTypeFromResponse(response.response))
            }
        }
    }
    
}
