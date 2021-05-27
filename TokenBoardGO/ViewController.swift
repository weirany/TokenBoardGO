import UIKit
import IQDropDownTextField
import StoreKit

class ViewController: UIViewController {

    @IBOutlet weak var goalText: IQDropDownTextField!
    @IBOutlet weak var s0: UIButton!
    @IBOutlet weak var s1: UIButton!
    @IBOutlet weak var s2: UIButton!
    @IBOutlet weak var s3: UIButton!
    @IBOutlet weak var s4: UIButton!
    
    var stars: [UIButton] = []
    var starsStatus: [Bool] = []
    
    let goals = ["❓","🍕","🍟","🐒","🐳","🐇","🌻","🍄","🎃","☃️","🍎","🍉","🍇","🧀","🍗","🍔","🌭","🍝","🌮","🍜","🍦","🍰","🍬","🍭","🍫","🍿","🍩","🍪","🍴","⚽️","🏀","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","🏸","🏊‍♀️","🛀","🎗","🏆","🎤","🎮","🎼","🚕","🚌","🚒","✈️","🛥","🎡","📱","💻","📽","📺","💵","🔫","🔭","⛱","📖","❤️","♠️"]
    
    let UDK_starsStatus = "starsStatus"
    let UDK_goal = "goal"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.stars = [s0, s1, s2, s3, s4]

        // first time loading the app? initialize Users Defaults
        if UserDefaults.standard.string(forKey: UDK_goal) == nil {
            UserDefaults.standard.set(self.goals[0], forKey: UDK_goal)
        }
        starsStatus = (UserDefaults.standard.array(forKey: UDK_starsStatus) ?? []) as! [Bool]
        if starsStatus.count != 5 {
            starsStatus = [false, false, false, false, false]
            UserDefaults.standard.set(starsStatus, forKey: UDK_starsStatus)
        }
        
        goalText.isOptionalDropDown = false
        goalText.itemList = self.goals
        goalText.setSelectedRow(0, animated: false)
        
        // load the saved defaults
        // Goal emoji
        let goalIndex = goals.firstIndex(of: UserDefaults.standard.string(forKey: UDK_goal)!)!
        goalText.setSelectedRow(goalIndex, animated: false)
        // stars status
        for i in 0...4 {
            setStar(index: i, set: starsStatus[i])
        }
    }
    
    @IBAction func goalChanged(_ sender: Any) {
        UserDefaults.standard.set(goalText.selectedItem!, forKey: UDK_goal)
    }

    @IBAction func starClicked(_ sender: UIButton) {
        let index = sender.tag
        starsStatus[index] = !starsStatus[index]
        UserDefaults.standard.set(starsStatus, forKey: UDK_starsStatus)
        setStar(index: index, set: starsStatus[index])
        // prompt to rate the app if 5 stars are set
        if !starsStatus.contains(false) {
            if #available(iOS 10.3,*) {
                SKStoreReviewController.requestReview()
            }
        }
    }

    func setStar(index: Int, set: Bool) {
        if set {
            self.stars[index].setTitle("🌟", for: .normal)
        }
        else {
            self.stars[index].setTitle("⚪️", for: .normal)
        }
    }
}

