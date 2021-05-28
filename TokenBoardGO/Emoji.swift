import Foundation
import Smile

class Emoji {
    var emoji: String
    var alias: String
    var names: [String]
    
    init(emoji: String, alias: String, names: [String]) {
        self.emoji = emoji
        self.alias = alias
        self.names = names
    }
}

class AllEmojis {
    private var emojis: [Emoji]
    
    init() {
        self.emojis = []
        for e in emojiList {
            let names = Smile.name(emoji: e.value).map { $0.lowercased() }
            self.emojis.append(Emoji(emoji: e.value, alias: e.key.lowercased(), names: names))
        }
    }
    
    func filter(keyword: String) -> [Emoji] {
        if keyword == "" {
            return emojis
        }
        else {
            return emojis.filter { $0.alias.contains(keyword.lowercased())
                || $0.names.contains(where: { name in name.contains(keyword.lowercased()) })
            }
        }
    }
}
