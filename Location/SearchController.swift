import UIKit
import Alamofire
import SwiftyJSON



class SearchController: UITableViewController {
    
    var pub: Pub!
    var pubs = [Pub]()

    
        @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    

    @IBAction func FoodView(_ sender: UISegmentedControl) {
            searchRequest(value: sender.selectedSegmentIndex + 1)
    }
        
   
    @IBOutlet weak var SearchButton: UIButton!
    
    func searchRequest(value: Int) {
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "ContentType": "application/json"
        ]
        
        Alamofire.request("http://46.101.42.98/api/venues/search?food=\(value)", method: .get, parameters: nil, headers: headers).response { [unowned self] response in
            URLCache.shared.removeAllCachedResponses()
            guard let data = response.data else { return }
            
            let json = JSON(data: data)
            print(json)
            
            self.pubs.removeAll()
            
            for pubJSON in json["venues"].arrayValue {
                let pub = Pub(json: pubJSON)
                self.pubs.append(pub)
                
                
            }
            print(self.pubs.count)
            
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "searchResult" {
            let vc = segue.destination as! ResultsController
            vc.pubs = pubs
        }
        
    }
    
}



    
    
    
