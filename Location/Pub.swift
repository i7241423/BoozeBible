import Foundation
import SwiftyJSON
import CoreLocation

class Pub: CustomStringConvertible {
    
    var description: String {
        return "This pub is  \(name!) \(location!)"
    }
    
    let location: CLLocationCoordinate2D!
    let name: String!
    let sub: String!
    let desc: String!
    let addr: String!
    
    init(json: JSON) {
        location = CLLocationCoordinate2D(latitude: json["lat"].doubleValue, longitude: json["lng"].doubleValue)
        name = json["name"].stringValue
        sub = json["sub"].stringValue
        desc = json["description"].stringValue
        addr = json["addr"].stringValue
        
    }
    
}
