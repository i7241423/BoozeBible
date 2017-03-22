import UIKit

class PubDetailController: UIViewController {

    var pub: Pub!
    

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var telephone: UILabel!
    
    @IBOutlet weak var website: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //Venue image
        let image = UIImageView(image: UIImage(named: pub.name))
        imageView.image = image.image
        
        //Venuename
        navigationItem.title = pub.name!
       
        //Venue Description
        info.text = pub.desc!
        info.numberOfLines = 0
        info.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        //Venue Address
        address.text = pub.addr!
        
        //Venue Telephone
        telephone.text = pub.telephone!
        
        //Venue Website
        website.text = pub.website!
        
    
    }


}
