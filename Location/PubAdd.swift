import UIKit
import Alamofire
import SwiftyJSON



class PubAddController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    
    @IBAction func send(_ sender: Any) {
    
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "ContentType": "application/json"
        ]
        
        let params: [String: Any] = [
            "name": "Test",
            "sub": "Cheese and disco nightclub",
            "description": "Groove along with a thousand others to the anthems in our venue Vinyl; this is the new breed of club that has it all. ",
            "addr": "Fir Vale Rd, Bournemouth, BH1 2JA",
            "telephone": "0",
            "website": "",
            "lat": 50.722041,
            "lng": -1.873764,
        ]
        
        Alamofire.request("http://46.101.42.98/venues/add", method: .post, parameters: params, headers: headers).response { [unowned self] response in
            print("sent")
        }
 
        
    }

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Add new venue description
        textView.delegate = self
        textView.text = "A modern Wetherspoon's pub with basic decor, dark patterned carpets, real ales, ciders and pub grub"
        textView.textColor = UIColor.lightGray
        textView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 5
        
        

    //override func
    }
    //override func
    
    //When editing decription changes colour to black
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    //When finishing editing decription but didnt input anything chnages colour back to grey
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "A modern Wetherspoon's pub with basic decor, dark patterned carpets, real ales, ciders and pub grub"
            textView.textColor = UIColor.lightGray
        }
    }
    
//class
}
    
    
