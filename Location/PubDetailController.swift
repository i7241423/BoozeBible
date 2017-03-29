import UIKit

class PubDetailController: UIViewController {

    var pub: Pub!
    var speciality: Speciality!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var telephone: UILabel!
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
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
        address.numberOfLines = 0
        address.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        //Venue Telephone
        telephone.text = pub.telephone!
        
        //Venue Website
        website.text = pub.website!
        
    
    }


}

extension PubDetailController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        if indexPath.row == 0 {
            cell.textLabel?.text = "'Cost of pint'"
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "'Drinks speciality'"
        } else if indexPath.row == 2 {
            cell.textLabel?.text = "'Ambiance'"
        } else if indexPath.row == 3 {
            cell.textLabel?.text = "'Food'"
        } else if indexPath.row == 4 {
            cell.textLabel?.text = "'Beer garden or smoking area'"
        } else if indexPath.row == 5 {
            cell.textLabel?.text = "'Additional activities'"
        } else if indexPath.row == 6 {
            cell.textLabel?.text = "'Music'"
        } else {
            cell.textLabel?.text = "Cost of Cheapest Pint?"
        }
        return cell
    }
    
}
