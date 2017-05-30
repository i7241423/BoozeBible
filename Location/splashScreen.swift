import UIKit
import RevealingSplashView


class SplashScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialize a revealing Splash with with the iconImage, the initial size and the background color
        let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "icon_logo")!,iconInitialSize: CGSize(width: 150, height: 238.41), backgroundColor: UIColor(red: 107/255, green: 191/255, blue: 159/255, alpha: 1.0))
        
        //Adds the revealing splash view as a sub view
        self.view.addSubview(revealingSplashView)
        
        //Starts animation
        revealingSplashView.startAnimation(){
            print("Completed")
            self.performSegue(withIdentifier: "firstSegue", sender: nil)
        }
    }
    
    
}
