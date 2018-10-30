
@testable import SoundCloudMemory

import XCTest

class InitialViewControllerTests: XCTestCase {

    var viewController: InitialViewController!
    
    var spyDelegate: SpyGameSetupDelegate! // decleration just under delegate folder
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "initialViewController") as? InitialViewController
        spyDelegate = SpyGameSetupDelegate()
        viewController.gameSetup = GameSetup()
        viewController.gameSetup.delegate = spyDelegate
        UIApplication.shared.keyWindow!.rootViewController = viewController // make root vc
    }

    override func tearDown() {
        viewController = nil
        spyDelegate = nil
    }
    
    func testViewControllerNotNil() {
        XCTAssertNotNil(viewController)
    }
    
    func testPlayButtonNotNil() {
        XCTAssertNotNil(viewController.playButton)
    }
    
    func testHowToPlayButtonNotNil() {
        XCTAssertNotNil(viewController.howToPlayButton)
    }
    
    func testProgressLabelNotNil() {
        XCTAssertNotNil(viewController.progressLabel)
    }
    
    func testActivityIndicatorNotNil() {
        XCTAssertNotNil(viewController.activityIndicator)
    }
    
    func testGameSetupDelegate() {
        let ex = expectation(description: "Expecting state changes")
        viewController.gameSetup.setup()
        spyDelegate.expectation = ex // assign expectation
        
        waitForExpectations(timeout: 2) { (error) in
            if let anError = error {
                XCTFail("error: \(anError)")
            }
        }
    }
}
