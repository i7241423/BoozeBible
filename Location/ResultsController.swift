import UIKit
import Alamofire
import SwiftyJSON



class ResultsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var ttableView: UITableView!

    
    var pub: Pub!
    var pubs = [Pub]()
    
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        Alamofire.request("http://46.101.42.98/api/venues.json").responseJSON { response in
         
            URLCache.shared.removeAllCachedResponses()
            guard let data = response.data else { return }
            
            let json = JSON(data: data)
            
            for pubJSON in json["data"].arrayValue {
                let pub = Pub(json: pubJSON)
                self.pubs.append(pub)
            }
            
            
        self.ttableView.reloadData()
        }
        
        ttableView.dataSource = self

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let pub = sender as? Pub else { return }
        
        if segue.identifier == "ViewPub" {
            let vc = segue.destination as! PubDetailController
            vc.pub = pub
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pubs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell
        
        let pub = pubs[indexPath.row]
        
        cell?.titleLabel.text = pub.name
        
        return cell!
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pub = pubs[indexPath.row]
        performSegue(withIdentifier: "ViewPub", sender: pub)
    }

//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        // When there is no text, filteredData is the same as the original data
//        // When user has entered text into the search box
//        // Use the filter method to iterate over all items in the data array
//        // For each item, return true if the item should be included and false if the
//        // item should NOT be included
//        pub = searchText.isEmpty ? data : data.filter { (item: String) -> Bool in
//            // If dataItem matches the searchText, return true to include it
//            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
//        }
//        
//        ttableView.reloadData()
//    }
    
}


    
    



