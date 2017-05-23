import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation

class PubAddController: UIViewController, UITextViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
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
        
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "ContentType": "application/json"
        ]
        
        let params: [String: String] = [
            "name": nameView.text!,
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
                self.submitNotice(self.title = "Unsucessfully Added Venue!")
                print(encodingError)
            }
        })
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func submitNotice(){
        
        let alertController = UIAlertController(title: "Venue Added!", message: "The venue, \(nameView.text!), was successfully saved.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // Oulet for venue image
    
    @IBOutlet weak var pickedImaged: UIImageView!
    
    
    // Access the photo library on your phone
    
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
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
    
    

    @IBOutlet weak var nameView: UITextField!
    
    @IBOutlet weak var subNameView: UITextField!
    
    
    //View did load function
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        nameView.delegate = self
        subNameView.delegate = self
        

    }
}
    
