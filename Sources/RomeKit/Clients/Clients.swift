import Alamofire
import ObjectMapper
import Dispatch

public class Clients {
    public static func all(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping ([Client]?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(route: .clients, params: [])
        
        NetworkManager.sharedInstance.request(url, method: .get).responseString(queue: queue) { response in
            switch response.result {
            case .success(let clientsJSON):
                if let clients = Mapper<Client>().mapArray(JSONString: clientsJSON) {
                    completionHandler(clients, nil)
                } else {
                    completionHandler(nil, Errors.ErrorMappingClients)
                }
            case .failure:
                completionHandler(nil, Errors.errorTypeFromResponse(response: response.response))
            }
            
        }
        
    }
    
    public static func create(
        name: String,
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (Client?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(route: .clients, params: [])
        let params = ["name": name]
        
        NetworkManager.sharedInstance.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).responseString(queue: queue) { response in
            switch response.result {
            case .success(let clientJSON):
                if let client = Mapper<Client>().map(JSONString: clientJSON) {
                    completionHandler(client, nil)
                } else {
                    completionHandler(nil, Errors.ErrorMappingClients)
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
        
        let url = RomeRoutes.url(route: .clients, params: [id])
        
        NetworkManager.sharedInstance.request(url, method: .delete).responseString(queue: queue) { response in
            switch response.result {
            case .success:
                completionHandler(true, nil)
            case .failure:
                completionHandler(false, Errors.errorTypeFromResponse(response: response.response))
            }
            
        }
        
    }
    
}
