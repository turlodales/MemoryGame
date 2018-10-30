
@testable import SoundCloudMemory

import XCTest

class CardViewUnitTests: XCTestCase {

    var cardView: CardView!
    
    override func setUp() {
        cardView = CardView(image: UIImage(named: "icon-soundcloud")!)
    }

    override func tearDown() {
        cardView = nil
    }
    
    func testInitialState() {
        XCTAssertFalse(cardView.isFlipped)
    }
    
    func testFlip() {
        cardView.flip()
        sleep(1)
        XCTAssertTrue(cardView.isFlipped) // must be true
    }
}
