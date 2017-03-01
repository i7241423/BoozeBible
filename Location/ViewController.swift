import UIKit
import MapKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    var pubs = [Pub]()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.delegate = self
        mapView.setUserTrackingMode(.follow, animated: true)
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "ContentType": "application/json"
        ]
        
        Alamofire.request("http://46.101.42.98/venues/index", method: .get, parameters: nil, headers: headers).response { [unowned self] response in
            URLCache.shared.removeAllCachedResponses()
            guard let data = response.data else { return }
            
            let json = JSON(data: data)
            
            print(json)
            
            
        }
        
//        Alamofire.request("http://46.101.42.98/venues/index.json").response { [unowned self] response in
//            URLCache.shared.removeAllCachedResponses()
//            guard let data = response.data else { return }
//            
//            let json = JSON(data: data)
//            
//            print(json)
//            for pubJSON in json["pubs"].arrayValue {
//                
//                let pub = Pub(json: pubJSON)
//                self.pubs.append(pub)
//                
//                let annotation = PubAnnotation(pub: pub)
//                self.mapView.addAnnotation(annotation)
//            }
//            
//        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewPub" {
            let vc = segue.destination as! PubDetailController
            vc.pub = sender as! Pub
        }
    }
    
}


extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //guard let location = locations.last else { return }
        //print(location)
        
    }
    
}


extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    
        if annotation is MKUserLocation { return nil }
        
        let identifier = "Pub"
        
        if let annotation = annotation as? PubAnnotation {
            
            
            let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:identifier)
            annotationView.isEnabled = true
            annotationView.canShowCallout = true
            
            
            let imageView = UIImageView(image: UIImage(named: annotation.pub.name))
            imageView.frame = CGRect( x: 0, y: 0, width: 40, height: 40)
            annotationView.leftCalloutAccessoryView = imageView
            
            annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            return annotationView
            
        }
        
        return nil
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if let pubAnnotation = view.annotation as? PubAnnotation {
            performSegue(withIdentifier: "ViewPub", sender: pubAnnotation.pub)
        }
        
        //    let ac = UIAlertController(title: "Hello World", message: "Some message", preferredStyle: .alert)
        //    ac.addAction(UIAlertAction(title: "OK", style: .default))
        //    present(ac, animated: true)
        
    }
    
    
    
}



