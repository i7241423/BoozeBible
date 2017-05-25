import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation

class PopUpOpeningTimesController: UIViewController{
    
    var pub: Pub!

    
    @IBOutlet weak var openingTimesLabel: UILabel!
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Venue Description
        openingTimesLabel.text = pub.hours!
        openingTimesLabel.numberOfLines = 0
        openingTimesLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        
    }
    
    
    
}
