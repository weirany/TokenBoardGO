import UIKit
import IQDropDownTextField
import SwiftyUserDefaults

class ViewController: UIViewController {

    @IBOutlet weak var goalText: IQDropDownTextField!
    @IBOutlet weak var s0: UIButton!
    @IBOutlet weak var s1: UIButton!
    @IBOutlet weak var s2: UIButton!
    @IBOutlet weak var s3: UIButton!
    @IBOutlet weak var s4: UIButton!
    
    var stars: [UIButton] = []
    
    let goals = ["❓","🍕","🍟","🐒","🐳","🐇","🌻","🍄","🎃","☃️","🍎","🍉","🍇","🧀","🍗","🍔","🌭","🍝","🌮","🍜","🍦","🍰","🍬","🍭","🍫","🍿","🍩","🍪","🍴","⚽️","🏀","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","🏸","🏊‍♀️","🛀","🎗","🏆","🎤","🎮","🎼","🚕","🚌","🚒","✈️","🛥","🎡","📱","💻","📽","📺","💵","🔫","🔭","⛱","📖","❤️","♠️"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.stars = [s0, s1, s2, s3, s4]

        // first time loading the app? initialize Users Defaults
        if Defaults[.goal].isEmpty {
            Defaults[.goal] = self.goals[0]
        }
        if Defaults[.starsStatus].count != 5 {
            Defaults[.starsStatus] = [false, false, false, false, false]
        }
        
        goalText.isOptionalDropDown = false
        goalText.itemList = self.goals
        goalText.setSelectedRow(0, animated: false)
        
        // load the saved defaults
        // Goal emoji
        let goalIndex = goals.index(of: Defaults[.goal])!
        goalText.setSelectedRow(goalIndex, animated: false)
        // stars status
        for i in 0...4 {
            setStar(index: i, set: Defaults[.starsStatus][i])
        }
    }
    
    @IBAction func goalChanged(_ sender: Any) {
        Defaults[.goal] = goalText.selectedItem!
    }

    @IBAction func starClicked(_ sender: UIButton) {
        let index = sender.tag
        Defaults[.starsStatus][index] = !(Defaults[.starsStatus][index])
        setStar(index: index, set: Defaults[.starsStatus][index])
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

