import UIKit

class PubDetailController: UIViewController {

    var pub: Pub!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var address: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        name.text = pub.name!
        
       let image = UIImageView(image: UIImage(named: pub.name))
        imageView.image = image.image
        
        
        
        info.text = pub.desc!
        info.numberOfLines = 0
        info.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        address.text = pub.addr!
       
    
          print(pub)
    }


}
