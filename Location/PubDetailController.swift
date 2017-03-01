import UIKit

class PubDetailController: UIViewController {

    var pub: Pub!
    @IBOutlet weak var name: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        name.text = pub.name!
        
//        let title = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
//        title.center = CGPoint(x: 160, y: 85)
//        title.textAlignment = .left
//        title.text = pub.name
//        title.numberOfLines = 0
//        title.lineBreakMode = NSLineBreakMode.byWordWrapping
//        self.view.addSubview(title)
    
        
        let image = UIImageView(image: UIImage(named: pub.name))
        image.frame = CGRect( x: 60, y: 100, width: 160, height: 160)
        self.view.addSubview(image)

        let description = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
        description.center = CGPoint(x: 160, y: 325)
        description.textAlignment = .left
        description.text = pub.desc
        description.numberOfLines = 0
        description.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.view.addSubview(description)
        
        let address = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
        address.center = CGPoint(x: 160, y: 430)
        address.textAlignment = .left
        address.text = pub.addr
        address.numberOfLines = 0
        address.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.view.addSubview(address)

    
          print(pub)
    }


}
