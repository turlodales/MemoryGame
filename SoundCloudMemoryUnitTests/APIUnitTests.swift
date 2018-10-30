
@testable import SoundCloudMemory

import XCTest

class APIUnitTests: XCTestCase {

    lazy var mockTrack: Track = {
        return Track(id: "11223344", imageUrl: "https://www.gstatic.com/webp/gallery/1.jpg") // google static
    }()
    
    override func setUp() {

    }

    override func tearDown() {

    }

    func testPlaylistTracksRequest() {
        let ex = expectation(description: "Expecting http response not nil")
        
        SoundCloudAPI.shared.getPlaylistTracks().done { (results) in
            XCTAssertNotNil(results)
            XCTAssertGreaterThan(results.count, 0) // must have more than 0 playlist tracks
            XCTAssertNotNil(results[0].id) // have id
            XCTAssertNotNil(results[0].imageUrl) // have image url
            ex.fulfill()
        }.catch { (error) in
            XCTFail("error: \(error)")
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let anError = error {
                XCTFail("error: \(anError)")
            }
        }
    }
    
    func testDownloadTrackImages() {
        let ex = expectation(description: "Expecting downlaod images successfully")
        
        SoundCloudAPI.shared.downloadTrackImage(track: mockTrack).done { (result) in
            XCTAssertNotNil(result)
            XCTAssertNotNil(result.id) // needs to have id
            XCTAssertNotNil(result.image) // needs to have non-nil image
            XCTAssertEqual(self.mockTrack.id, result.id) // resulting card object will have the same id
            ex.fulfill()
        }.catch { (error) in
            XCTFail("error: \(error)")
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let anError = error {
                XCTFail("error: \(anError)")
            }
        }
    }

}
