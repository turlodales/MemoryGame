
import UIKit

struct Environment {
    
    static var shared : Platform = {
        if let env = Bundle.main.object(forInfoDictionaryKey: "Environment") as? String{
            if env == "debug" {
                return Platform.debug
            }else if env == "release" {
                return Platform.release
            }
        }
        // if not provided, build with release env
        return Platform.release
    }()
    
    enum Platform : String {
        case debug = "debug"
        case release = "release"
        
        var debug : Bool {
            switch self {
            case .debug:
                return true
            case .release:
                return false
            }
        }

        var apiBaseUrl : String {
            switch self {
            case .debug, .release:
                return "https://api.soundcloud.com/playlists/79670980"
            }
        }
        
        var clientId : String {
            switch self {
            case .debug, .release:
                return ""
            }
        }
        
        var clientSecret : String {
            switch self {
            case .debug, .release:
                return ""
            }
        }
    }
}
