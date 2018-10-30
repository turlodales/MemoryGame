
@testable import SoundCloudMemory

import XCTest

class SpyGameDelegate: GameDelegate{
    
    var expectation: XCTestExpectation?
    
    var method: String?
    
    func show(card: Card, atIndex index: Int) {
        if let method = method,
            method == "show" {
            expectation?.fulfill()
        }
    }
    
    func hide(cards: [Card], atIndices indices: [Int]) {
        if let method = method,
            method == "hide" {
            expectation?.fulfill()
        }
    }
    
    func gameDidFinish() {
        
    }
}

