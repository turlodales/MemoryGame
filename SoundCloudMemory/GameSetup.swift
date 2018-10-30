
import UIKit
import PromiseKit

// GameSetup class prepares game resources before its initiation.
// A set of procedures called when setup function is invoked. (Template)
// State is a internal state of the setup.
class GameSetup: NSObject{
    
    public var delegate: GameSetupDelegate? = nil
    
    public func setup() {
        // template methods sequentially called
        // 1. Fetch Playlist Tracks from SoundCloud API
        // 2. Download Images & Prepare Cards
        // 3. Prepare Game & Ready
        self.getPlaylistTracks()
        .then{ (tracks: [Track]) -> Promise<[Card]> in
            self.prepareCards(listOfTracks: tracks)
        }.done{ (cards: [Card]) in
            try self.prepareGame(listOfCards: cards)
        }.catch { error in
            self.state = .failed
            self.delegate?.gameSetupDidFail(error: error)
        }
    }
    
    // MARK: - States
    public enum State {
        case initial
        case fetching
        case downloading
        case preparing
        case ready
        case failed
        
        var localizedDescription: String {
            switch self {
            case .initial:
                return NSLocalizedString("game-state-initial", comment: "")
            case .fetching:
                return NSLocalizedString("game-state-fetching", comment: "")
            case .downloading:
                return NSLocalizedString("game-state-downloading", comment: "")
            case .preparing:
                return NSLocalizedString("game-state-preparing", comment: "")
            case .ready:
                return NSLocalizedString("game-state-ready", comment: "")
            case .failed:
                return NSLocalizedString("game-state-failed", comment: "")
            }
        }
    }
    
    private var state: State = .initial {
        didSet { delegate?.stateDidChange(state: self.state) }
    }
}

// MARK: - Template Functions
extension GameSetup {
    
    private func getPlaylistTracks() -> Promise<[Track]> {
        self.state = .fetching
        return SoundCloudAPI.shared.getPlaylistTracks()
    }
    
    private func prepareCards(listOfTracks: [Track]) -> Promise<[Card]>{
        self.state = .downloading // state downloading
        return Promise { seal in
            // list of promises (image download).
            var cards : [Card] = [Card]() // list of cards (game)
        
            for track in listOfTracks { // download each track image & create card model with each of 'em
                SoundCloudAPI.shared.downloadTrackImage(track: track)
                .done { (card) in
                    cards.append(card) // append card model to list
                    
                    // check whether fetching is done
                    if cards.count == listOfTracks.count {
                        seal.fulfill(cards)
                    }
                }.catch { (error) in
                    seal.reject(error)
                }
            }
        }
    }
    
    private func prepareGame(listOfCards: [Card]) throws {
        self.state = .preparing
        // create game instance & prepare
        let game = Game(cards: listOfCards)
        try game.initialise()
        self.state = .ready // set state ready
        delegate?.gameSetupDidSucceed(game: game)
    }
}
