import Foundation
import ObjectMapper

public class ISO8601MilliSecondsDateTransform: DateFormatterTransform {
    
    public init() {
        
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        super.init(dateFormatter: formatter)
        
    }
    
}