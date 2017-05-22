import UIKit
import Alamofire
import SwiftyJSON

class PubDetailController: UIViewController {

    var pub: Pub!
    var pubs = [Pub]()

    var images = ["venue-cost","venue-speciality","venue-ambiance","venue-food","venue-garden","venue-activity","venue-music"]
    
    var name = ["Cost of a Pint", "Speciality", "Ambiance", "Food", "Outside area", "Activity", "Music"]
    
    @IBOutlet weak var venueTitle: UILabel!
    @IBOutlet weak var hours: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var postcode: UILabel!
    @IBOutlet weak var telephoneButton: UIButton!
    @IBOutlet weak var websiteButton: UIButton!

    //collection view
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func rate(_ sender: Any) {
        let pub = self.pub
        performSegue(withIdentifier: "rate", sender: pub)

    }
    
    @IBAction func websiteLink(_ sender: UIButton) {
    
        let url = URL(string: "http://" + pub.website)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }

       
    }
    @IBAction func telephoneLink(_ sender: Any) {
       
        let url = "telprompt://\(pub.telephone.replacingOccurrences(of: " ", with: ""))"
        
        guard let number = URL(string: url ) else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
        
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
        
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
      
       
        //Venue image
        imageView.imageFromServerURL(urlString: pub.imageURL)
        
        //Title Venue Name
        venueTitle.text = pub.name!
       
        //Venue Name
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
      
        //Venue Description
        hours.text = pub.hours!
        hours.numberOfLines = 0
        hours.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        
        //Venue Telephone
        telephoneButton.setTitle(pub.telephone, for: .normal)
        
        //Venue Website
        websiteButton.setTitle(pub.name + "'s Website", for: .normal)
        
      
        collectionView.reloadData()
        
    
    }
    

}



extension PubDetailController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PubDetailCollectionViewCell
        cell?.facilityImage.image = UIImage(named: images[indexPath.row])
        cell?.facilityLabel.text = name[indexPath.row]
        if indexPath.row == 0 {
            cell?.facilityText.text = pub.venueCosts
        } else if indexPath.row == 1 {
            cell?.facilityText.text = pub.venueSpecialities
        } else if indexPath.row == 2 {
            cell?.facilityText.text = pub.venueAmbiances
        } else if indexPath.row == 3 {
            cell?.facilityText.text = pub.venueFoods
        } else if indexPath.row == 4 {
            cell?.facilityText.text = pub.venueGardens
        } else if indexPath.row == 5 {
            cell?.facilityText.text = pub.venueActivities
        } else if indexPath.row == 6 {
            cell?.facilityText.text = pub.venueMusics
        } else {
            cell?.facilityText.text = pub.venueCosts
        }
        
        
        return cell!
        
        //    cell.textLabel?.text = pub.name
    }
    
}


