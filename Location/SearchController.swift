import UIKit
import Alamofire
import SwiftyJSON




class SearchController: UIViewController {

    @IBOutlet var tableview: UITableView!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        tableview.delegate = self
        tableview.dataSource = self
    }

    
}

extension SearchController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Venue")!
        
        if indexPath.row == 0 {
            cell.textLabel?.text = "What is the cost of the cheapest pint?"
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "Does the venue have a drinks speciality?"
        } else if indexPath.row == 2 {
            cell.textLabel?.text = "What is the ambiance of the venue?"
        } else if indexPath.row == 3 {
            cell.textLabel?.text = "Does the venue sell food?"
        } else if indexPath.row == 4 {
            cell.textLabel?.text = "Does the venue have a beer garden or smoking area?"
        } else if indexPath.row == 5 {
            cell.textLabel?.text = "Does the venue have the following activity?"
        } else if indexPath.row == 6 {
            cell.textLabel?.text = "What sort of music is usually played?"
        } else {
            cell.textLabel?.text = "Cost of Cheapest Pint?"
        }
        return cell
    }
    
    
}
