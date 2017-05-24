import UIKit
import Alamofire
import SwiftyJSON



class ResultsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var ttableView: UITableView!

    
    var pub: Pub!
    var pubs = [Pub]()
    
    
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        ttableView.dataSource = self
        
        
        let logo = UIImage(named: "logo-top")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView

        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let pub = sender as? Pub else { return }
        
        if segue.identifier == "ViewPub" {
            let vc = segue.destination as! PubDetailController
            vc.pub = pub
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pubs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell
        
        let pub = pubs[indexPath.row]
        
       // cell?.contentView.layer =
        
        cell?.titleLabel.text = pub.name
        
        cell?.venueImage.imageFromServerURL(urlString: pub.imageURL)

        
        return cell!
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pub = pubs[indexPath.row]
        performSegue(withIdentifier: "ViewPub", sender: pub)
    }

    
}


    
    




