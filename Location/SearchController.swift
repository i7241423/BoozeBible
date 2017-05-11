import UIKit
import Alamofire
import SwiftyJSON



class SearchController: UITableViewController {
    
    var pub: Pub!
    var pubs = [Pub]()
    
    let foodList: [String] = ["No","Yes","Snacks"]

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
    }

    @IBAction func FoodView(_ sender: UISegmentedControl) {
        
            switch segmentedControl.selectedSegmentIndex
            {
            case 0:
                textLabel.text = foodList[0]
                
            case 1:
                textLabel.text = foodList[1]
            case 2:
                textLabel.text = foodList[2]
            default:
                break; 
            }
        }
        
    @IBOutlet weak var SearchButton: UIButton!
}

//http://46.101.42.98/api/venues/search?food=1 URL TO SEARCH

    
    
    
