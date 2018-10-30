
@testable import SoundCloudMemory

import XCTest

class GameUnitTests: XCTestCase {
    
    var listOfMockCards : [Card]!
    
    var game: Game!
    
    override func setUp() {
        super.setUp()
        listOfMockCards = [
            Card(id: "1", image: UIImage(named: "icon-soundcloud")!),
            Card(id: "2", image: UIImage(named: "icon-soundcloud")!),
            Card(id: "3", image: UIImage(named: "icon-soundcloud")!),
            Card(id: "4", image: UIImage(named: "icon-soundcloud")!),
            Card(id: "1", image: UIImage(named: "icon-soundcloud")!),
            Card(id: "2", image: UIImage(named: "icon-soundcloud")!),
            Card(id: "3", image: UIImage(named: "icon-soundcloud")!),
            Card(id: "4", image: UIImage(named: "icon-soundcloud")!)
        ]
        self.game = Game(cards: listOfMockCards)
    }
    
    override func tearDown() {
        listOfMockCards = nil
        game = nil
    }
    
    func testInitialise() {
        do {
            try game.initialise()
            XCTAssertNotNil(game.cardAt(index: 15)) // ensure we have 16 cards (4*4) grid
        }catch{
            XCTFail()
        }
    }
    
    func testImageSizeLimit() {
        do {
            try game.initialise()
            XCTAssertNil(game.cardAt(index: 16)) // must be nil
        }catch{
            XCTFail()
        }
    }
    
    func testSelectCard() {
        do {
            try game.initialise()
            let card = game.cardAt(index: 0)
            game.didSelectCardAt(index: 0)
            sleep(1)
            XCTAssertFalse(game.existInPaired(card: card!))
        }catch{
            XCTFail()
        }
    }
    
    func testPairCard() {
        game.didSelectCardAt(index: 0)
        game.didSelectCardAt(index: 4)
        sleep(1)
        XCTAssertTrue(game.existInPaired(card: game.cardAt(index: 0)!))
    }    
}
