
@testable import SoundCloudMemory

import XCTest

class CardUnitTests: XCTestCase {
    
    var card: Card!
        
    override func setUp() {
        super.setUp()
        card = Card(id: "12380679", image: UIImage(named: "icon-soundcloud")!)
    }
    
    override func tearDown() {
        card = nil
    }
    
    func testCardNotNil() {
        XCTAssertNotNil(card)
    }
    
    func testCardIdEquality() {
        XCTAssertEqual(card.id, "12380679")
    }

    func testCardImageNotNil() {
        XCTAssertNotNil(card.image)
    }
}
