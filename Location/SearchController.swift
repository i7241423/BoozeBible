import UIKit
import Alamofire
import SwiftyJSON



class SearchController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var pub: Pub!
    var pubs = [Pub]()
    var pickerSource: [String]!
    var selectedRow: Int!

    
    var images = ["pint","speciality","ambiance","food","garden","activities","blank1","music","blank"]
    
    var prices = ["£1 - £2.50","£2.50 - £4.00","£4.00 - £5.50", "£5.50+"]
    var speciality = ["None", "Rum", "Tequila","Gin", "Whisky", "Brandy","Ale's", "Cocktails", "Vodka","Wine"]
    var ambiance = ["Traditional", "Modern", "Funky", "Student", "Cheap", "Sports"]
    var food = ["No", "Yes", "Snacks"]
    var beerGarden = ["Beer Garden", "Smoking Area", "None"]
    var activities = ["Dart Board", "Snooker/Pool", "Ping-Pong", "Comedy Nights", "Quiz Nights", "Sky Sports", "Live Bands", "None"]
    var music = ["Rap", "Rock", "Pop", "Garage", "Grime", "Varied", "House", "Drum and Bass"]

    var name = ["cost", "speciality", "style", "food", "garden", "activity", "none", "music"]

    @IBOutlet weak var SearchButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    

    @IBAction func searchButton(_ sender: UIButton) {
        searchRequest(value: pickerView.selectedRow(inComponent: 0) + 1)
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchCollectionView.delegate = self
        self.searchCollectionView.dataSource = self
        
        pickerSource = prices
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        pickerView.alpha = 0
        
        
        let logo = UIImage(named: "logo-top")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
        
        pickerView.setValue(UIColor(red: 107/255, green: 191/255, blue: 159/255, alpha: 1.0), forKeyPath: "textColor")
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(true)
        
        pickerView.alpha = 0
        //SearchButton.alpha = 0
    
    }
    
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
    
    func forPickerAnimation() {
        
        pickerView.alpha = 0
        //SearchButton.alpha = 0
        
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: .curveEaseIn, animations: {
            
            self.pickerView.alpha = 1
            //self.SearchButton.alpha = 1
            
            
        }, completion: nil)
        
    }
    func dismissPicker() {
        
        pickerView.alpha = 1
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: .curveEaseIn, animations: {
            
            self.pickerView.alpha = 0
            
            
        }, completion: nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissPicker()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "searchResult" {
            
            pickerView.alpha = 0
            
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
        
        forPickerAnimation()
        
        
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
             pickerView.alpha = 0
        }
        pickerView.reloadAllComponents()
        
        print ("selected row is" , indexPath.row)
        
        
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


