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
    let postcode: String!
    let telephone: String!
    let website: String!
    let imgURL: String!
    let venueID: String!
    
    //Categories
    let venueMusics: String!
    let venueActivities: String!
    let venueGardens: String!
    let venueFoods: String!
    let venueAmbiances: String!
    let venueCosts: String!
    let venueSpecialities: String!
    
    init(json: JSON) {
        location = CLLocationCoordinate2D(latitude: json["lat"].doubleValue, longitude: json["lng"].doubleValue)
        name = json["name"].stringValue
        sub = json["sub"].stringValue
        desc = json["description"].stringValue
        addr = json["addr"].stringValue
        postcode = json["postcode"].stringValue
        telephone = json["telephone"].stringValue
        website = json["website"].stringValue
        imgURL = json["imgURL"].stringValue
        venueID = json["id"].stringValue
        
        //Categories
        venueMusics = json["venue_musics"][0]["music_id"].stringValue
        venueActivities = json["venue_activities"][0]["activity_id"].stringValue
        venueGardens = json["venue_gardens"][0]["garden_id"].stringValue
        venueFoods = json["venue_foods"][0]["food_id"].stringValue
        venueAmbiances = json["venue_ambiances"][0]["ambiance_id"].stringValue
        venueCosts = json["venue_costs"][0]["cost_id"].stringValue
        venueSpecialities = json["venue_specialities"][0]["speciality_id"].stringValue
        
    }
    
}
