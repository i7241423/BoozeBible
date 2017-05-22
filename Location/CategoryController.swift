import UIKit
import Alamofire
import SwiftyJSON



class CategoryController: UIViewController  {
    
    
    @IBOutlet weak var pickerView: UIPickerView!

    @IBOutlet weak var tableView: UITableView!
    
    var pickerSource: [String]!
    var pub: Pub!
    
    var images = ["venue-cost","venue-speciality","venue-ambiance","venue-food","venue-garden","venue-activity","venue-music"]
    
    var dataArray = [
        ["param": "cost_id", "table": "venue-costs"],
        ["param": "speciality_id", "table": "venue-specialities"],
        ["param": "style_id", "table": "venue-styles"],
        ["param": "food_id", "table": "venue-foods"],
        ["param": "garden_id", "table": "venue-gardens"],
        ["param": "activity_id", "table": "venue-activities"],
        ["param": "music_id", "table": "venue-musics"]
    ]
    
    var data: [String: String]?
    
    var prices = ["£1 - £2.50","£2.50 - £4.00","£4.00 - £5.50", "£5.50+"]
    var speciality = ["None", "Rum", "Tequila","Gin", "Whisky", "Brandy","Ale's", "Cocktails", "Vodka","Wine"]
    var ambiance = ["Traditional", "Modern", "Funky", "Student", "Cheap", "Sports"]
    var food = ["No", "Yes", "Snacks"]
    var beerGarden = ["Beer Garden", "Smoking Area", "None"]
    var activities = ["Dart Board", "Snooker Table", "Ping-Pong Table", "Comedy Nights", "Quiz Nights", "Sky Sports"]
    var music = ["Rap", "Rock", "Pop", "Garage", "Grime", "Varied", "House", "Drum and Bass"]

    @IBAction func send(_ sender: Any) {
        
        guard let data = data else { return }
        guard let tableName = data["table"], let paramName = data["param"] else { return }

        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "ContentType": "application/json"
        ]
        
        let params: [String: Any] = [
            "venue_id": 66, // this needs to change
            paramName: pickerView.selectedRow(inComponent: 0) + 1
        ]
        
        Alamofire.request("http://46.101.42.98/\(tableName)/add", method: .post, parameters: params, headers: headers).response { [unowned self] response in
            print("sent")
            self.submitNotice()
            print(params)
        }
        
    }
    
    func submitNotice(){
        
        let alertController = UIAlertController(title: "Yippeeee", message: "The rating was successfully submitted.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomTableViewCell
        
        cell?.rateImageView.image = UIImage(named: images[indexPath.row])

        if indexPath.row == 0 {
            cell?.rateTitleLabel.text = "Cost of pint? (Cheapest)"
        } else if indexPath.row == 1 {
            cell?.rateTitleLabel.text = "Drinks speciality?"
        } else if indexPath.row == 2 {
            cell?.rateTitleLabel.text = "Ambiance?"
        } else if indexPath.row == 3 {
            cell?.rateTitleLabel.text = "Food?"
        } else if indexPath.row == 4 {
            cell?.rateTitleLabel.text = "Beer garden or smoking area?"
        } else if indexPath.row == 5 {
            cell?.rateTitleLabel.text = "Additional activities?"
        } else if indexPath.row == 6 {
           cell?.rateTitleLabel.text = "Music?"
        } else {
            cell?.rateTitleLabel.text = "Cost of pint? (Cheapest)"
        }
        return cell!
        //cell.textLabel?.text
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
        
        data = dataArray[indexPath.row]
        
        self.view.endEditing(true)
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
