
import UIKit

protocol GameSetupDelegate {
    func stateDidChange(state: GameSetup.State)
    func gameSetupDidFail(error: Error)
    func gameSetupDidSucceed(game: Game)
}
