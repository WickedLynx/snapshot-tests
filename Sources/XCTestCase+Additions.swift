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
                let imageName = "\(prefix)-result"
                screenshotWriter.save(screenshot: result, named: imageName)
                attach(image: result, named: imageName)
                if let expected = expected {
                    let imageName = "\(prefix)-expected"
                    screenshotWriter.save(screenshot: expected, named: imageName)
                    attach(image: expected, named: imageName)
                }
                if let difference = difference {
                    let imageName = "\(prefix)-difference"
                    screenshotWriter.save(screenshot: difference, named: imageName)
                    attach(image: difference, named: imageName)
                }
            }
        }
        if !doesMatch {
            XCTFail(message)
        }
    }

    func attach(image: UIImage, named name: String) {
        let attachment = XCTAttachment(image: image)
        attachment.lifetime = .keepAlways
        attachment.name = name
        add(attachment)
    }
}
