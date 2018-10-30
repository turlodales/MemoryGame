
import UIKit
import SwiftyJSON

// A single card object of Memory game.
class Card : NSObject{
    
    var id: String
    
    var image: UIImage
    
    init(id: String, image: UIImage) {
        self.id = id
        self.image = image
    }
}
