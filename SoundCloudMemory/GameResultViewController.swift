
import UIKit

class GameResultViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButtonDidTouch(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
