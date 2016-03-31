import Foundation

class FileHelpers {
    
    static func loadJSONStringFromFile(name: String) -> String? {
        
        if let path = NSBundle(forClass: self).pathForResource(name, ofType: ".json") {
            if let data = NSData(contentsOfFile: path) {
                return String(data: data, encoding:NSUTF8StringEncoding)
            }
        }
        
        return nil
        
    }
    
    static func loadZipDataFromFile(name: String) -> NSData? {
        
        if let path = NSBundle(forClass: self).pathForResource(name, ofType: ".zip") {
            if let data = NSData(contentsOfFile: path) {
                return data
            }
        }
        
        return nil
        
    }
    
}