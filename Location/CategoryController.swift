import UIKit
import MapKit
import Alamofire
import SwiftyJSON



class CategoryController: UIViewController  {
    
    @IBOutlet weak var pickerView: UIPickerView!

    @IBOutlet weak var tableView: UITableView!
    
    var pickerSource: [String]!
    
    var prices = ["£1","£2","£3"]
    var names = ["jon", "sam", "ash"]
    
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            pickerSource = prices
        } else {
            pickerSource = names
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
