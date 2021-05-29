import UIKit

class GoalViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var emojiCollection: UICollectionView!
    
    private var allEmojis: AllEmojis?
    private var emojis: [Emoji] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.allEmojis = AllEmojis()
            self.emojis = self.allEmojis!.filter(keyword: "")
            DispatchQueue.main.async {
                self.emojiCollection.reloadData()
            }
        }
        
        searchBar.delegate = self
        emojiCollection.delegate = self
        emojiCollection.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let allEmojis = allEmojis {
            emojis = allEmojis.filter(keyword: searchText)
            emojiCollection.reloadData()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojis.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emojiCell", for: indexPath) as! EmojiViewCell
        cell.emojiLabel.text = emojis[indexPath.row].emoji
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UserDefaults.standard.set(emojis[indexPath.row].emoji, forKey: UDK_goal)
        self.navigationController?.popViewController(animated: true)
    }
}
