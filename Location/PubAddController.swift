import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation

class PubAddController: UIViewController, UITextViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    var userLocation: CLLocation?
    
    // Send data from form to DB
    @IBAction func send(_ sender: Any) {
        
        
        guard let userLocation = userLocation else {
            //dont have user location...
            return
        }
        
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "ContentType": "application/json"
        ]
        
        let params: [String: Any] = [
            "name": nameView.text!,
            "sub": subNameView.text!,
            "description": textView.text!,
            "addr": addrView.text!,
            "telephone": phoneView.text!,
            "website": siteView.text!,
            "lat": userLocation.coordinate.latitude,
            "lng": userLocation.coordinate.longitude,
        ]
        
        Alamofire.request("http://46.101.42.98/api/venues.json", method: .post, parameters: params, headers: headers).response { [unowned self] response in
            
            guard let data = response.data else {
                //handle error and let user know...
                print("no data returned")
                return
            }
            
            let json = JSON(data: data)
            
            guard let _ = json["success"].bool else {
                print("invalid data")
                return
            }
            //everything worked...
        }
        
        submitNotice()
    }
    
    func submitNotice(){
        
        let alertController = UIAlertController(title:"Venue Added!", message: "The venue, \(nameView.text!), was successfully saved.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // Oulet for venue image
    
    @IBOutlet weak var pickedImaged: UIImageView!
    
    // Access the camera on your phone
    
    @IBAction func camerButtonAction(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // Access the photo library on your phone
    
    @IBAction func photLibraryAction(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // Save the photo into the app
    
    @IBAction func saveAction(_ sender: UIButton) {
        let imageData = UIImageJPEGRepresentation(pickedImaged.image!, 0.6)
        let compressedJPEGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPEGImage!, nil, nil, nil)
        saveNotice()
    }
    
    func saveNotice(){
        let alertController = UIAlertController(title:"Image Saved!", message: "Your picture was successfully saved.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // Display image selected from camera or photo library

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!){
        pickedImaged.image = image
        self.dismiss(animated: true, completion: nil);
    }
    
   
    
    @IBOutlet weak var textView: UITextView! //description

    @IBOutlet weak var nameView: UITextField!
    
    @IBOutlet weak var subNameView: UITextField!
    
    @IBOutlet weak var addrView: UITextField!
    
    @IBOutlet weak var phoneView: UITextField!
    
    @IBOutlet weak var siteView: UITextField!
    
    //View did load function
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        nameView.delegate = self
        subNameView.delegate = self
        textView.delegate = self
        addrView.delegate = self
        phoneView.delegate = self
        siteView.delegate = self
    
        //Add new venue DESCRIPTION styling
        
        textView.text = "'A modern Wetherspoon's pub with basic decor, dark patterned carpets, real ales, ciders and pub grub'"
        textView.textColor = UIColor(red: 0.78, green: 0.78, blue: 0.80, alpha: 1.0)
        textView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 5

    }
    
    //When editing decription changes colour to black
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor(red: 0.78, green: 0.78, blue: 0.80, alpha: 1.0){
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    //When finishing editing decription but didnt input anything chnages colour back to grey
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "'A modern Wetherspoon's pub with basic decor, dark patterned carpets, real ales, ciders and pub grub'"
            textView.textColor = UIColor(red: 0.78, green: 0.78, blue: 0.80, alpha: 1.0)
        }
    }
    
}
    
