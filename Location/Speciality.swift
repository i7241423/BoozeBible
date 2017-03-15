import Foundation
import SwiftyJSON
import CoreLocation

class Speciality: CustomStringConvertible {
    
    var description: String {
        return "This speciality is  \(name!)"
    }
    
    let name: String!
    
    
    init(json: JSON) {
        name = json["name"].stringValue
    }
    
    
    
}
