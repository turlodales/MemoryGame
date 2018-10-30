
import UIKit

extension UIAlertController {
    
    static func showAlert(in controller: UIViewController, title: String, message: String, negativeAction: UIAlertAction? = nil, positiveAction: UIAlertAction? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let negative = negativeAction{
            alert.addAction(negative)
        }
        if let positive = positiveAction{
            alert.addAction(positive)
        }
        controller.present(alert, animated: true, completion: nil)
    }

}
