
@testable import SoundCloudMemory

import XCTest

class GameViewControllerTests: XCTestCase {

    var cards: [Card]!
    
    var viewController: GameViewController!
    
    var spyDelegate: SpyGameDelegate! // decleration just under delegate folder
    
    override func setUp() {
        cards = [Card]()
        for i in 0...7{
            cards.append(Card(id: String(format:"%d",(i+1)), image: UIImage(named: "icon-soundcloud")!)) // same image but different ids(just a mock)
        }
        cards.append(contentsOf: cards) // duplicate cards
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "gameViewController") as? GameViewController
        spyDelegate = SpyGameDelegate()
        viewController.game = Game(cards: cards)
        viewController.game.delegate = spyDelegate
        UIApplication.shared.keyWindow!.rootViewController = viewController // make root vc
    }
    
    override func tearDown() {
        cards = nil
        viewController = nil
        spyDelegate = nil
    }
    
    func testLayoutVisible() {
        XCTAssertNotNil(viewController)
        XCTAssertNotNil(viewController.stackView)
        XCTAssertGreaterThan(viewController.stackView.subviews.count, 0) // must have more than 0 subviews
    }
    
    func testCardsVisible() {
        XCTAssertEqual(viewController.stackView.subviews.count, 4) // We have a grid layout 4*4 (4 columns)
        XCTAssertEqual(viewController.listOfCardsViews.count, cards.count) // have same card views and cards
    }
    
    func testShowCard() {
        let ex = expectation(description: "show card delegate method should be invoked")
        spyDelegate.method = "show"
        spyDelegate.expectation = ex
        viewController.game.didSelectCardAt(index: 0)

        waitForExpectations(timeout: 2) { (error) in
            if let anError = error {
                XCTFail("error: \(anError)")
            }
        }
    }
    
    func testHideCards() {
        let ex = expectation(description: "hide cards delegate method should be invoked")
        spyDelegate.method = "hide"
        spyDelegate.expectation = ex
        viewController.game.didSelectCardAt(index: 0)
        viewController.game.didSelectCardAt(index: 2)
        
        waitForExpectations(timeout: 2) { (error) in
            if let anError = error {
                XCTFail("error: \(anError)")
            }
        }
    }
    
    func testCardEquality() {
        let card1 = viewController.game.cardAt(index: 0)!
        let card2 = viewController.game.cardAt(index: 8)!
        XCTAssertEqual(card1.id, card2.id)
    }
    
    func testCardMatch() {
        let card1 = viewController.game.cardAt(index: 0)!
        viewController.game.didSelectCardAt(index: 0) // flip
        sleep(1) // sleep
        viewController.game.didSelectCardAt(index: 8) // flip
        sleep(1) // sleep
        XCTAssertTrue(viewController.game.existInPaired(card: card1))
    }

}
