import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation

class PubAddController: UIViewController, UITextViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var userLocation: CLLocation?
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo: [String : Any]) {
        guard let image = didFinishPickingMediaWithInfo[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        pickedImaged.image = image
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func demo(_ sender: Any) {
        
        guard let image = pickedImaged.image else { return }
        
        view.endEditing(true)
        
        print("button")
        
        guard let userLocation = userLocation else {
            //dont have user location...
            return
        }
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "ContentType": "application/json"
        ]
        
        let params: [String: String] = [
            "name": nameView.text!,
            "sub": subNameView.text!,
            "description": textView.text!,
            "addr": addrView.text!,
            "postcode": postCodeView.text!,
            "telephone": phoneView.text!,
            "website": siteView.text!,
            "lat": "\(userLocation.coordinate.latitude)",
            "lng": "\(userLocation.coordinate.longitude)",
            //"imgURL": pickedImaged.image!
        ]
    
        let imageData = UIImageJPEGRepresentation(image, 0)!

        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "upload", fileName: "upload.jpg", mimeType: "image/jpeg")
            
            for (key, value) in params {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
            
        }, to: "http://46.101.42.98/api/venues.json",
           encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    self.submitNotice()
                    debugPrint(response)
                }
            case .failure(let encodingError):
                print("Fail")
                print(encodingError)
            }
        })
        
        
//        Alamofire.request("http://46.101.42.98/api/venues.json", method: .post, parameters: params, headers: headers).response { [unowned self] response in
//            
//            guard let data = response.data else {
//                //handle error and let user know...
//                print("no data returned")
//                return
//            }
//            
//            let json = JSON(data: data)
//            
//            guard let _ = json["success"].bool else {
//                print("invalid data")
//                print(params)
//                return
//            }
//            //everything worked...
//        }
        
       
        
        
        
        
    }
    
    func upload(_ image: UIImage) {
        
        let parameters: [String: String] = [
            "venue_id": "1"
        ]
        
        let imageData = UIImageJPEGRepresentation(image, 0)!
        
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "upload", fileName: "upload.jpg", mimeType: "image/jpeg")
            
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
            
        }, to: "http://46.101.42.98/api/venues.json",
           encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("SUCCESS")
                    debugPrint(response)
                }
            case .failure(let encodingError):
                print("Fail")
                print(encodingError)
            }
        })
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    @IBOutlet weak var textView: UITextView!

    @IBOutlet weak var nameView: UITextField!
    
    @IBOutlet weak var subNameView: UITextField!
    
    @IBOutlet weak var addrView: UITextField!
    
    @IBOutlet weak var postCodeView: UITextField!
    
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
    
