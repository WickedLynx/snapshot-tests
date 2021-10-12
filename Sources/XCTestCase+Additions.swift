import Foundation
import XCTest

extension XCTestCase {
    static var alwaysWriteScreenshots = false
    
    func wait(for duration: TimeInterval = 1) {
        let expectation = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: duration + 1)
    }

    func assertScreenshotsMatch(
        result: UIImage,
        expected: UIImage?,
        message: String,
        prefix: String,
        screenshotWriter: ScreenshotWriter,
        writeResults: Bool = true
    ) {
        let (doesMatch, difference) = expected != nil
            ? result.matches(expected!)
            : (false, nil)
        if
            !doesMatch || XCTestCase.alwaysWriteScreenshots {
            if writeResults || XCTestCase.alwaysWriteScreenshots {
                screenshotWriter.save(screenshot: result, named: "\(prefix)-result")
                if let expected = expected {
                    screenshotWriter.save(screenshot: expected, named: "\(prefix)-expected")
                }
                if let difference = difference {
                    screenshotWriter.save(screenshot: difference, named: "\(prefix)-difference")
                    let attachment = XCTAttachment(image: difference)
                    attachment.lifetime = .keepAlways
                    add(attachment)
                }
            }
        }
        if !doesMatch {
            XCTFail(message)
        }
    }
}
