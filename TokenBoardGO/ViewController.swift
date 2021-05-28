import UIKit
import StoreKit

class ViewController: UIViewController {

    @IBOutlet weak var goalButton: UIButton!
    @IBOutlet weak var s0: UIButton!
    @IBOutlet weak var s1: UIButton!
    @IBOutlet weak var s2: UIButton!
    @IBOutlet weak var s3: UIButton!
    @IBOutlet weak var s4: UIButton!
    
    var stars: [UIButton] = []
    var starsStatus: [Bool] = []
    
    let goals = ["❓","🍕","🍟","🐒","🐳","🐇","🌻","🍄","🎃","☃️","🍎","🍉","🍇","🧀","🍗","🍔","🌭","🍝","🌮","🍜","🍦","🍰","🍬","🍭","🍫","🍿","🍩","🍪","🍴","⚽️","🏀","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","🏸","🏊‍♀️","🛀","🎗","🏆","🎤","🎮","🎼","🚕","🚌","🚒","✈️","🛥","🎡","📱","💻","📽","📺","💵","🔫","🔭","⛱","📖","❤️","♠️"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalButton.titleLabel?.numberOfLines = 1
        goalButton.titleLabel?.adjustsFontSizeToFitWidth = true
        goalButton.titleLabel?.lineBreakMode = .byClipping
        
        self.stars = [s0, s1, s2, s3, s4]

        // first time loading the app? initialize Users Defaults
        if UserDefaults.standard.string(forKey: UDK_goal) == nil {
            UserDefaults.standard.set("❓", forKey: UDK_goal)
        }
        starsStatus = (UserDefaults.standard.array(forKey: UDK_starsStatus) ?? []) as! [Bool]
        if starsStatus.count != 5 {
            starsStatus = [false, false, false, false, false]
            UserDefaults.standard.set(starsStatus, forKey: UDK_starsStatus)
        }
        
        // load the saved values
        goalButton.setTitle(UserDefaults.standard.string(forKey: UDK_goal)!, for: .normal)
        for i in 0...4 {
            setStar(index: i, set: starsStatus[i])
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        goalButton.setTitle(UserDefaults.standard.string(forKey: UDK_goal)!, for: .normal)
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

