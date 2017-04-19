import UIKit
import Alamofire
import SwiftyJSON



class SearchController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
 
    @IBOutlet weak var ttableView: UITableView!
    
    
    var venuesArray = [AnyObject]()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        Alamofire.request("http://46.101.42.98/api/venues.json").responseJSON { response in
         
            let result = response.result
            if let dict = result.value as? Dictionary<String,AnyObject>{
                if let innerDict = dict["data"]{
                    self.venuesArray = innerDict as! [AnyObject]
                    self.ttableView.reloadData()
                }
            }
        
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venuesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell
        
        let name = venuesArray[indexPath.row]["name"]
        
        cell?.titleLabel.text = name as? String
        
        return cell!
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewPub" {
            let vc = segue.destination as! PubDetailController
            vc.pub = sender as! Pub
        }
    }
    
    
    
}

