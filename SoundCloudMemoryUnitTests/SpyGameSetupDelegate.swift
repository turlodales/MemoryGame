
@testable import SoundCloudMemory

import XCTest

class SpyGameSetupDelegate: GameSetupDelegate{
    
    var expectation: XCTestExpectation?
    
    func gameSetupDidFail(error: Error) {
        
    }
    
    func gameSetupDidSucceed(game: Game) {
        
    }
    
    func stateDidChange(state: GameSetup.State) {
        expectation?.fulfill()
    }
}

