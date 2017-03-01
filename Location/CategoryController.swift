import UIKit
import MapKit
import Alamofire
import SwiftyJSON



class CategoryController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var Picker1: UIPickerView!
    
    var Array = ["£1","£2","£3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Picker1.delegate = self
        Picker1.dataSource = self
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Array [row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Array.count
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1

    }


}
