import Alamofire
import ObjectMapper

public class Clients {
    
    public static func all(
        completionHandler: ([Client]?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(.Clients, params: [])
        
        NetworkManager.sharedInstance().request(.GET, url).responseString { response in
            
            switch response.result {
            case .Success(let clientsJSON):
                if let clients = Mapper<Client>().mapArray(clientsJSON) {
                    completionHandler(clients, nil)
                } else {
                    completionHandler(nil, Errors.ErrorMappingClients)
                }
            case .Failure:
                completionHandler(nil, Errors.ErrorFetchingClients)
            }
            
        }
        
    }
    
    public static func create(
        name: String,
        completionHandler: (Client?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(.Clients, params: [])
        let params = ["name": name]
        
        NetworkManager.sharedInstance().request(.POST, url, parameters: params, encoding: ParameterEncoding.JSON, headers: nil).responseString { response in
            
            switch response.result {
            case .Success(let clientJSON):
                if let client = Mapper<Client>().map(clientJSON) {
                    completionHandler(client, nil)
                } else {
                    completionHandler(nil, Errors.ErrorMappingClients)
                }
            case .Failure:
                completionHandler(nil, Errors.ErrorAddingClient)
            }
            
        }
    }
    
    public static func delete(
        id: String,
        completionHandler: (Bool?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(.Clients, params: [id])
        
        NetworkManager.sharedInstance().request(.DELETE, url, parameters: nil, encoding: .URL, headers: nil).responseString { response in
            
            switch response.result {
            case .Success:
                completionHandler(true, nil)
            case .Failure:
                completionHandler(false, Errors.ErrorDeletingClient)
            }
            
        }
        
    }
    
}