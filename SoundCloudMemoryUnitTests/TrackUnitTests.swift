
@testable import SoundCloudMemory

import XCTest
import SwiftyJSON

class TrackUnitTests: XCTestCase {

    var track1: Track!
    
    var track2: Track!
    
    var sampleJSONStr = "{\"id\": \"12380679\", \"artwork_url\": \"https://www.gstatic.com/webp/gallery/2.jpg\"}"
    
    override func setUp() {
        super.setUp()
        // track one from object creation
        track1 = Track(id: "12380679", imageUrl: "https://www.gstatic.com/webp/gallery/2.jpg")
        // track2 from json
        if let dataFromString = sampleJSONStr.data(using: .utf8, allowLossyConversion: false) {
            let json = JSON(data: dataFromString)
            track2 = Track(withJson: json)
        }
    }
    
    override func tearDown() {
        track1 = nil
        track2 = nil
    }
    
    func testTrack1NotNil() {
        XCTAssertNotNil(track1)
    }
    
    func testTrack2NotNil() {
        XCTAssertNotNil(track2)
    }
    
    func testTrack1Id() {
        XCTAssertEqual(track1.id, "12380679")
    }
    
    func testTrack2Id() {
        XCTAssertEqual(track2.id, "12380679")
    }
    
    func testTrack1ImageUrl() {
        XCTAssertEqual(track1.imageUrl, "https://www.gstatic.com/webp/gallery/2.jpg")
    }
    
    func testTrack2ImageUrl() {
        XCTAssertEqual(track2.imageUrl, "https://www.gstatic.com/webp/gallery/2.jpg")
    }
    
    func testTracksIdEquality() {
        XCTAssertEqual(track1.id, track2.id)
    }
    
    func testTracksImageEquality() {
        XCTAssertEqual(track1.imageUrl, track2.imageUrl)
    }

}
