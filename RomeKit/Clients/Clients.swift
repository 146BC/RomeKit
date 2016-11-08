import Alamofire
import ObjectMapper

public class Clients {
    
    public static func all(
        queue: DispatchQueue? = nil,
        completion: @escaping ([Client]?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(.Clients, params: [])

        NetworkManager.shared().request(url).responseJSON(queue: queue) { json in
            
            switch json.result {
            case .success(let clientsJSON):
                if let clients = Mapper<Client>().mapArray(JSONObject: clientsJSON) {
                    completion(clients, nil)
                } else {
                    completion(nil, Errors.ErrorMappingClients)
                }
            case .failure:
                completion(nil, Errors.errorTypeFromResponse(json.response))
            }
            
        }
        
    }
    
    public static func create(
        _ name: String,
        queue: DispatchQueue? = nil,
        completion: @escaping (Client?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(.Clients, params: [])
        let params = ["name": name]

        NetworkManager.shared().request(url,
                                        method: .post,
                                        parameters: params,
                                        encoding: JSONEncoding.default)
            .responseJSON(queue: queue) { data in
            
            switch data.result {
            case .success(let clientJSON):
                if let client = Mapper<Client>().map(JSONObject: clientJSON) {
                    completion(client, nil)
                } else {
                    completion(nil, Errors.ErrorMappingClients)
                }
            case .failure:
                completion(nil, Errors.errorTypeFromResponse(data.response))
            }
            
        }
    }
    
    public static func delete(
        _ id: String,
        queue: DispatchQueue? = nil,
        completion: @escaping (Bool?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(.Clients, params: [id])

        NetworkManager.shared().request(url,
                                        method: .delete,
                                        encoding: URLEncoding.default)
            .responseString(queue: queue) { response in
            
            switch response.result {
            case .success:
                completion(true, nil)
            case .failure:
                completion(false, Errors.errorTypeFromResponse(response.response))
            }
            
        }
        
    }
    
}
