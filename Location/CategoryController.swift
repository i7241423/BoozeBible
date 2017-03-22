import UIKit
import Alamofire
import SwiftyJSON



class CategoryController: UIViewController  {
    
    
    @IBOutlet weak var pickerView: UIPickerView!

    @IBOutlet weak var tableView: UITableView!
    
    var pickerSource: [String]!
    
    var prices = ["£1 - £2.50","£2.50 - £4.00","£4.00 - £5.50", "£5.50+"]
    var speciality = ["None", "Tequila", "Gin","Rum", "Whisky", "Vodka","Ale's", "Brandy", "Wine","Cocktails"]
    var ambiance = ["Traditional", "Modern", "Funky", "Student", "Cheap", "Sports"]
    var food = ["No", "Yes", "Snacks"]
    var beerGarden = ["No", "Yes"]
    var activities = ["Dart Board", "Snooker Table", "Ping-Pong Table", "Comedy Nights", "Quiz Nights", "Sky Sports"  ]
    var music = ["Rock", "Pop", "Rap", "Garage", "Grime", "Varied"]
    

    @IBAction func send(_ sender: Any) {
        
        //Send data to database regarding speciality

        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "ContentType": "application/json"
        ]
        
        let params: [String: Any] = [
            "venue_id": 4,
            "speciality_id": 3
            
        ]
        
        Alamofire.request("http://46.101.42.98/venue-specialities/add", method: .post, parameters: params, headers: headers).response { [unowned self] response in
        }
        
        //Send data to database regarding cost of pint
        
        let paramss: [String: Any] = [
            "venue_id": 3,
            "cost_id": 3
        ]
        
        Alamofire.request("http://46.101.42.98/venue-costs/add", method: .post, parameters: paramss, headers: headers).response { [unowned self] response in
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerSource = prices
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
}

extension CategoryController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!

        if indexPath.row == 0 {
            cell.textLabel?.text = "Cost of pint? (Cheapest)"
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "Drinks speciality?"
        } else if indexPath.row == 2 {
            cell.textLabel?.text = "Ambiance?"
        } else if indexPath.row == 3 {
            cell.textLabel?.text = "Food?"
        } else if indexPath.row == 4 {
            cell.textLabel?.text = "Beer garden or smoking area?"
        } else if indexPath.row == 5 {
            cell.textLabel?.text = "Additional activities?"
        } else if indexPath.row == 6 {
           cell.textLabel?.text = "Music?"
        } else {
            cell.textLabel?.text = "Cost of Cheapest Pint?"
        }
        return cell
    }
    
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            pickerSource = prices
        } else if indexPath.row == 1 {
            pickerSource = speciality
        } else if indexPath.row == 2 {
            pickerSource = ambiance
        } else if indexPath.row == 3 {
            pickerSource = food
        } else if indexPath.row == 4 {
            pickerSource = beerGarden
        } else if indexPath.row == 5 {
            pickerSource = activities
        } else if indexPath.row == 6 {
            pickerSource = music
        } else {
            pickerSource = prices
        }
    
        pickerView.reloadAllComponents()
    }
    
}

extension CategoryController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerSource.count
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    
}
