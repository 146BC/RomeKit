import Alamofire
import ObjectMapper

public class Clients {
    
    public static func all(
        queue: dispatch_queue_t? = nil,
        completionHandler: ([Client]?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(.Clients, params: [])
        
        NetworkManager.sharedInstance().request(.GET, url).responseString(queue: queue) { response in
            
            switch response.result {
            case .Success(let clientsJSON):
                if let clients = Mapper<Client>().mapArray(clientsJSON) {
                    completionHandler(clients, nil)
                } else {
                    completionHandler(nil, Errors.ErrorMappingClients)
                }
            case .Failure:
                completionHandler(nil, Errors.errorTypeFromResponse(response.response))
            }
            
        }
        
    }
    
    public static func create(
        name: String,
        queue: dispatch_queue_t? = nil,
        completionHandler: (Client?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(.Clients, params: [])
        let params = ["name": name]
        
        NetworkManager.sharedInstance().request(.POST, url, parameters: params, encoding: .JSON, headers: nil).responseString(queue: queue) { response in
            
            switch response.result {
            case .Success(let clientJSON):
                if let client = Mapper<Client>().map(clientJSON) {
                    completionHandler(client, nil)
                } else {
                    completionHandler(nil, Errors.ErrorMappingClients)
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
        
        let url = RomeRoutes.url(.Clients, params: [id])
        
        NetworkManager.sharedInstance().request(.DELETE, url, parameters: nil, encoding: .URL, headers: nil).responseString(queue: queue) { response in
            
            switch response.result {
            case .Success:
                completionHandler(true, nil)
            case .Failure:
                completionHandler(false, Errors.errorTypeFromResponse(response.response))
            }
            
        }
        
    }
    
}