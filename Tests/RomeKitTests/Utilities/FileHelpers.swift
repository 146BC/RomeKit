import Foundation

class FileHelpers {
    
    private static func fixturesURL() -> URL {
        return URL(fileURLWithPath: #file)
            .deletingLastPathComponent()
            .appendingPathComponent("..")
            .appendingPathComponent("Sample Data")
            .standardized
    }
    
    private static func url(forResource name: String, ofType type: String) -> URL? {
        let url = fixturesURL().appendingPathComponent(name).appendingPathExtension(type)
        if FileManager.default.fileExists(atPath: url.path) {
            return url
        }
        return nil
    }
    
    static func loadJSONStringFromFile(_ name: String) -> String? {
        if let url = url(forResource: name, ofType: "json") {
            if let data = try? Data(contentsOf: url) {
                return String(data: data, encoding: .utf8)
            }
        }
        return nil
    }
    
    static func loadZipDataFromFile(_ name: String) -> Data? {
        if let url = url(forResource: name, ofType: "zip") {
            if let data = try? Data(contentsOf: url) {
                return data
            }
        }
        return nil
    }
    
}
