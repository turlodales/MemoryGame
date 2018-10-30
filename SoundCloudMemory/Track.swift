
import UIKit
import SwiftyJSON

// A single track object on SoundCloud API.
// We used id and artwork_url as object properties, rest is ignored
class Track: NSObject {
    
    var id: String
    
    var imageUrl: String
    
    init(id: String, imageUrl: String) {
        self.id = id
        self.imageUrl = imageUrl
    }
    
    init(withJson json: JSON){
        self.id = json["id"].stringValue
        self.imageUrl = json["artwork_url"].stringValue // image url
    }
}
