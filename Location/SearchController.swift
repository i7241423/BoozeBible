import UIKit
import Alamofire
import SwiftyJSON



class SearchController: UIViewController {
    
    var pub: Pub!
    var pubs = [Pub]()
    var pickerSource: [String]!

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var pickView: UIPickerView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    var prices = ["£1 - £2.50","£2.50 - £4.00","£4.00 - £5.50", "£5.50+"]
    var speciality = ["None", "Rum", "Tequila","Gin", "Whisky", "Brandy","Ale's", "Cocktails", "Vodka","Wine"]
    var ambiance = ["Traditional", "Modern", "Funky", "Student", "Cheap", "Sports"]
    var food = ["No", "Yes", "Snacks"]
    var beerGarden = ["Beer Garden", "Smoking Area", "None"]
    var activities = ["Dart Board", "Snooker Table", "Ping-Pong Table", "Comedy Nights", "Quiz Nights", "Sky Sports"]
    var music = ["Rap", "Rock", "Pop", "Garage", "Grime", "Varied", "House", "Drum and Bass"]
    
    var dataArray = [
        ["table": "cost"],
         ["table": "speciality"],
          ["table": "style"],
           ["table": "food"],
            ["table": "garden"],
             ["table": "activity"],
              ["table": "music"],
       
    ]
    
    var data: [String: String]?


    @IBAction func FoodView(_ sender: UISegmentedControl) {
            //searchRequest(value: sender.selectedSegmentIndex + 1)
    }
    
    @IBAction func send(_ sender: Any) {
        
        let value = pickView.selectedRow(inComponent: 0) + 1
        
        guard let data = data else { return }
        guard let tableName = data["table"] else { return }
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "ContentType": "application/json"
        ]
        
        Alamofire.request("http://46.101.42.98/api/venues/search?\(tableName)=\(value)", method: .get, parameters: nil, headers: headers).response { [unowned self] response in
            URLCache.shared.removeAllCachedResponses()
            guard let data = response.data else { return }
            
            let json = JSON(data: data)
            print(json)
            
            self.pubs.removeAll()
            
            for pubJSON in json["venues"].arrayValue {
                let pub = Pub(json: pubJSON)
                self.pubs.append(pub)
                
                
            }
            print(self.pubs.count)
            
        }
    
    
    }


   
    @IBOutlet weak var SearchButton: UIButton!
    
//     func searchRequest(value: Int) {
//        
//        
//        let headers: HTTPHeaders = [
//            "Accept": "application/json",
//            "ContentType": "application/json"
//        ]
//        
//        Alamofire.request("http://46.101.42.98/api/venues/search?food=\(value)", method: .get, parameters: nil, headers: headers).response { [unowned self] response in
//            URLCache.shared.removeAllCachedResponses()
//            guard let data = response.data else { return }
//            
//            let json = JSON(data: data)
//            print(json)
//            
//            self.pubs.removeAll()
//            
//            for pubJSON in json["venues"].arrayValue {
//                let pub = Pub(json: pubJSON)
//                self.pubs.append(pub)
//                
//                
//            }
//            print(self.pubs.count)
//            
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerSource = prices
        
        pickView.dataSource = self
        pickView.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
 
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "searchResult" {
            let vc = segue.destination as! ResultsController
            vc.pubs = pubs
        }
        
    }
    
}

extension SearchController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        if indexPath.row == 0 {
            cell.textLabel?.text = "Cost of pint"
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "Speciality"
        } else if indexPath.row == 2 {
            cell.textLabel?.text = "Ambiance"
        } else if indexPath.row == 3 {
            cell.textLabel?.text = "Food"
        } else if indexPath.row == 4 {
            cell.textLabel?.text = "Beer garden or smoking area"
        } else if indexPath.row == 5 {
            cell.textLabel?.text = "Additional activities"
        } else if indexPath.row == 6 {
            cell.textLabel?.text = "Music?"
        } else {
            cell.textLabel?.text = "Cost of pint"
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
        
        pickView.reloadAllComponents()
        
        //data = dataArray[indexPath.row]
    }
    
}

extension SearchController: UIPickerViewDelegate, UIPickerViewDataSource {
    
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
