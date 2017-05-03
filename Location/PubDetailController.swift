import UIKit
import Alamofire
import SwiftyJSON

class PubDetailController: UIViewController {

    var pub: Pub!
    var pubs = [Pub]()
    var speciality: Speciality!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var postcode: UILabel!
    @IBOutlet weak var telephone: UILabel!
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func rate(_ sender: Any) {
        let pub = self.pub
        performSegue(withIdentifier: "rate", sender: pub)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let pub = sender as? Pub else { return }
        
        if segue.identifier == "rate" {
            let vc = segue.destination as! CategoryController
            vc.pub = pub
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request("http://46.101.42.98/api/venues.json").responseJSON { response in
            
            URLCache.shared.removeAllCachedResponses()
            guard let data = response.data else { return }
            
            let json = JSON(data: data)
            
            for pubJSON in json["data"].arrayValue {
                let pub = Pub(json: pubJSON)
                self.pubs.append(pub)
            }
        }
        
        tableView.delegate = self
        tableView.dataSource = self
      
       
        //Venue image
        let imageView = UIImageView()
        if let filePath = Bundle.main.path(forResource: pub.imgURL, ofType: "jpg"), let image = UIImage(contentsOfFile: filePath) {
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
        }
        
        
        //let image = UIImageView(image: UIImage(named: pub.name))
        //imageView.image = image.image

        
        
        //Venuename
        navigationItem.title = pub.name!
       
        //Venue Description
        info.text = pub.desc!
        info.numberOfLines = 0
        info.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        //Venue Address
        address.text = pub.addr!
        address.numberOfLines = 0
        address.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        //Venue postcode
        postcode.text = pub.postcode!
      
        
        //Venue Telephone
        telephone.text = pub.telephone!
        
        //Venue Website
        website.text = pub.website!
        website.numberOfLines = 0
        website.lineBreakMode = NSLineBreakMode.byWordWrapping
       
        tableView.reloadData()
    
    }
    

}


extension PubDetailController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        if indexPath.row == 0 {
            cell.textLabel?.text = pub.venueCosts
        } else if indexPath.row == 1 {
            cell.textLabel?.text = pub.venueSpecialities
        } else if indexPath.row == 2 {
            cell.textLabel?.text = pub.venueAmbiances
        } else if indexPath.row == 3 {
            cell.textLabel?.text = pub.venueFoods
        } else if indexPath.row == 4 {
            cell.textLabel?.text = pub.venueGardens
        } else if indexPath.row == 5 {
            cell.textLabel?.text = pub.venueActivities
        } else if indexPath.row == 6 {
            cell.textLabel?.text = pub.venueMusics
        } else {
            cell.textLabel?.text = pub.venueCosts
        }
        return cell
    }
    
}


