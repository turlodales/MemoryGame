
import XCTest

class SoundCloudMemoryUITests: XCTestCase {

    override func setUp() {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
    }

    override func tearDown() {

    }

    func testHowToPlay() {
        let app = XCUIApplication()
        app.buttons["How To Play"].tap()
        app.navigationBars["How To Play"].children(matching: .button).element.tap()
    }

    func testGamePlay(){
        
        let app = XCUIApplication()
        app.buttons["Play Game"].tap()
        
        let element9 = app.otherElements.containing(.navigationBar, identifier:"Memory Game").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let element13 = element9.children(matching: .other).element(boundBy: 0)
        let element = element13.children(matching: .other).element(boundBy: 0)
        element.tap()
        
        let element8 = element9.children(matching: .other).element(boundBy: 1)
        let element2 = element8.children(matching: .other).element(boundBy: 1)
        element2.tap()
        
        let element3 = element8.children(matching: .other).element(boundBy: 0)
        element3.tap()
        
        let element4 = element13.children(matching: .other).element(boundBy: 2)
        element4.tap()
        
        let element15 = element9.children(matching: .other).element(boundBy: 2)
        let element5 = element15.children(matching: .other).element(boundBy: 2)
        element5.tap()
        
        let element6 = element15.children(matching: .other).element(boundBy: 1)
        element6.tap()
        
        let element7 = element15.children(matching: .other).element(boundBy: 0)
        element7.tap()
        element2.tap()
        element8.children(matching: .other).element(boundBy: 2).tap()
        element15.children(matching: .other).element(boundBy: 3).tap()
        
        let element10 = element9.children(matching: .other).element(boundBy: 3)
        element10.children(matching: .other).element(boundBy: 3).tap()
        element10.children(matching: .other).element(boundBy: 2).tap()
        
        let element11 = element10.children(matching: .other).element(boundBy: 1)
        element11.tap()
        
        let element12 = element10.children(matching: .other).element(boundBy: 0)
        element12.tap()
        element5.tap()
        element6.tap()
        element7.tap()
        element3.tap()
        element.tap()
        element13.children(matching: .other).element(boundBy: 1).tap()
        
        let element14 = element13.children(matching: .other).element(boundBy: 3)
        element14.tap()
        element2.tap()
        element2.tap()
        element8.children(matching: .other).element(boundBy: 3).tap()
        element13.tap()
        element14.tap()
        element13.tap()
        element4.tap()
        element6.tap()
        element12.tap()
        element11.tap()
        element5.tap()
        element3.tap()
    }
}
