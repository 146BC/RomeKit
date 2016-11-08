import Foundation

class FileHelpers {
    
    static func loadJSONStringFromFile(name: String) -> String? {
        
        if let path = Bundle(for: self).path(forResource: name, ofType: ".json") {            
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                return String(data: data, encoding: .utf8)
            }
        }
        
        return nil
        
    }
    
    static func loadZipDataFromFile(name: String) -> Data? {
        
        if let path = Bundle(for: self).path(forResource: name, ofType: ".zip") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                return data
            }
        }
        
        return nil
        
    }
    
}
