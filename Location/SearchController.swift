import UIKit
import Alamofire
import SwiftyJSON



class SearchController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var pub: Pub!
    var pubs = [Pub]()
    var pickerSource: [String]!
    var selectedRow: Int!

    
    var images = ["cost-search","speciality-search","ambiance-search","food-search","garden-search","activity-search"," ","music-search"]
    
    var prices = ["£1 - £2.50","£2.50 - £4.00","£4.00 - £5.50", "£5.50+"]
    var speciality = ["None", "Rum", "Tequila","Gin", "Whisky", "Brandy","Ale's", "Cocktails", "Vodka","Wine"]
    var ambiance = ["Traditional", "Modern", "Funky", "Student", "Cheap", "Sports"]
    var food = ["No", "Yes", "Snacks"]
    var beerGarden = ["Beer Garden", "Smoking Area", "None"]
    var activities = ["Dart Board", "Snooker Table", "Ping-Pong Table", "Comedy Nights", "Quiz Nights", "Sky Sports"]
    var music = ["Rap", "Rock", "Pop", "Garage", "Grime", "Varied", "House", "Drum and Bass"]

    var name = ["cost", "speciality", "style", "food", "garden", "activity", "none", "music"]

    @IBOutlet weak var SearchButton: UIButton!
    
    func searchRequest(value: Int) {
        
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "ContentType": "application/json"
        ]
     
        
        Alamofire.request("http://46.101.42.98/api/venues/search?\(name[selectedRow])=\(value)", method: .get, parameters: nil, headers: headers).response { [unowned self] response in
            URLCache.shared.removeAllCachedResponses()
            guard let data = response.data else { return }
            
            let json = JSON(data: data)
            print(json)
            
            self.pubs.removeAll()
            
            for pubJSON in json["venues"].arrayValue {
                let pub = Pub(json: pubJSON)
                self.pubs.append(pub)
                
                
            }
            self.performSegue(withIdentifier: "searchResult", sender: nil)
            print(self.pubs.count)
            
        }
    }
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchCollectionView.delegate = self
        self.searchCollectionView.dataSource = self
        
        pickerSource = prices
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        
        let logo = UIImage(named: "logo-top")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView

        
    }
   
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "searchResult" {
            let vc = segue.destination as! ResultsController
            vc.pubs = pubs
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? SearchCollectionViewCell
        cell?.imageView.image = UIImage(named: images[indexPath.row])
        return cell! 
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        
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
        } else if indexPath.row == 7 {
            pickerSource = music
        } else {
            
        }
        pickerView.reloadAllComponents()
        
        print ("selected row is" , indexPath.row)
        
        
    }
    

    @IBAction func searchButton(_ sender: UIButton) {
        searchRequest(value: pickerView.selectedRow(inComponent: 0) + 1)
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


