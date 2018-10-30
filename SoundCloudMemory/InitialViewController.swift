
import UIKit

class InitialViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var howToPlayButton: UIButton!
    
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    internal var gameSetup: GameSetup!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func playButtonTouchInside(_ sender: Any) {
        gameSetup = GameSetup()
        gameSetup.delegate = self
        gameSetup.setup()
    }
}

extension InitialViewController {
    
    private func toggleProgress(loading: Bool) {
        let enableButtons = loading ? false : true
        playButton.isUserInteractionEnabled = enableButtons
        howToPlayButton.isUserInteractionEnabled = enableButtons
        progressLabel.isHidden = !loading
        activityIndicator.isHidden = !loading
    }
    
}

extension InitialViewController: GameSetupDelegate {
    
    func stateDidChange(state: GameSetup.State) {
        Logger.debug("Game setup state changed : \(state)")
        
        switch state {
        case .initial, .fetching, .downloading, .preparing:
            toggleProgress(loading: true)
            progressLabel.text = state.localizedDescription // update progress label
        case .ready, .failed:
            toggleProgress(loading: false)
        }
    }
    
    func gameSetupDidFail(error: Error) {
        UIAlertController.showAlert(in: self, title: NSLocalizedString("title-warning", comment: ""), message: error.localizedDescription, negativeAction: UIAlertAction(title: NSLocalizedString("action-okay", comment: ""), style: .cancel, handler: nil))
    }
    
    func gameSetupDidSucceed(game: Game) {
        Logger.debug("game setup is completed")
        if let vc = storyboard?.instantiateViewController(withIdentifier: "gameViewController") as? GameViewController {
            vc.game = game // set game
            vc.game.delegate = vc // set game delegate
            self.show(vc, sender: self) // show vc
        }
    }
}
