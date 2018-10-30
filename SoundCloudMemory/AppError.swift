
import UIKit

enum AppError: Swift.Error {
    case Game(GameError)
    enum GameError {
        case unsufficientImage
    }
    
    case API(APIError)
    enum APIError {
        case networkUnreachable
        case cantDownloadImage
        case noData
        case unknown
    }
}

// Localize error desc
extension AppError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .Game(.unsufficientImage):
            return NSLocalizedString("error-game-unsufficient-image", comment: "")
            
        case .API(.networkUnreachable):
            return NSLocalizedString("error-network", comment: "")
        case .API(.cantDownloadImage):
            return NSLocalizedString("error-cant-download-image", comment: "")
        case .API(.noData):
            return NSLocalizedString("error-no-data", comment: "")
            
        default:
            return NSLocalizedString("error-unknown", comment: "")
        }
    }
}
