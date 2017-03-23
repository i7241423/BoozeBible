import UIKit
import Alamofire
import SwiftyJSON



class PubAddController: UIViewController, UITextViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    // Send data from form to DB
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

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!){
        pickedImaged.image = image
        self.dismiss(animated: true, completion: nil);
    }
    
    func saveNotice(){
        let alertController = UIAlertController(title:"Image Saved!", message: "Your picture was successfully saved.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBOutlet weak var textView: UITextView!

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
    
