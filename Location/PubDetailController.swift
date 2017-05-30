import UIKit
import Alamofire
import SwiftyJSON
import MapKit

class PubDetailController: UIViewController {

    var pub: Pub!

    var images = ["venue-cost","venue-speciality","venue-ambiance","venue-food","venue-garden","venue-activity","venue-music"]
    
    var name = ["Cost of a Pint", "Speciality", "Ambiance", "Food", "Outside area", "Activity", "Music"]
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var categoryView: UIView!
    
    @IBOutlet weak var telephoneButton: UIButton!
    @IBOutlet weak var websiteButton: UIButton!
    
    @IBOutlet weak var venueTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var postcode: UILabel!

    //collection view
    @IBOutlet weak var collectionView: UICollectionView!
    

    @IBAction func openTimes(_ sender: Any) {
        let pub = self.pub
        performSegue(withIdentifier: "openTimes", sender: pub)
        
    }
    @IBAction func rate(_ sender: Any) {
        let pub = self.pub
        performSegue(withIdentifier: "pub", sender: pub)
    }
    
    @IBAction func websiteLink(_ sender: UIButton) {
    
        let url = URL(string: "http://" + pub.website)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }

       
    }
    @IBAction func telephoneLink(_ sender: UIButton) {
       
        let url = "telprompt://\(pub.telephone.replacingOccurrences(of: " ", with: ""))"
        
        guard let number = URL(string: url ) else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
        
    }
    
    @IBAction func directionsLink(_ sender: UIButton) {
        openMapForPlace()
    }
    
    func openMapForPlace() {

        let regionDistance:CLLocationDistance = 1000
        let coordinates = pub.location
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates!, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates!, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = pub.name
        mapItem.openInMaps(launchOptions: options)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "rate" {
            let vc = segue.destination as! CategoryController
            vc.pub = pub
        }
        
        if segue.identifier == "openTimes" {
            let vc = segue.destination as! PopUpOpeningTimesController
            vc.pub = pub
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        infoView.layer.shadowColor = UIColor.black.cgColor
        infoView.layer.shadowOpacity = 0.3
        infoView.layer.shadowOffset = CGSize.zero
        infoView.layer.shadowRadius = 7
        
        categoryView.layer.shadowColor = UIColor.black.cgColor
        categoryView.layer.shadowOpacity = 0.3
        categoryView.layer.shadowOffset = CGSize.zero
        categoryView.layer.shadowRadius = 7
        
        
        
        
        //Venue image
        imageView.imageFromServerURL(urlString: pub.imageURL)
        
        //Title Venue Name
        venueTitle.text = pub.name!
       
        // Navigation Venue Name
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
        
        
//        //Venue Telephone
//        telephoneButton.setTitle(pub.telephone, for: .normal)
//        
//        //Venue Website
//        websiteButton.setTitle(pub.name + "'s Website", for: .normal)
        
      
        self.collectionView.reloadData()
        
    
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


