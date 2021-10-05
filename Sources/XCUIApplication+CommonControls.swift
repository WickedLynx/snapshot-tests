import Foundation
import XCTest

extension XCUIApplication {

    func wait(for duration: TimeInterval = 1) {
        let semaphore = DispatchSemaphore(value: 0)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: DispatchTime.now() + duration + 1)
    }

    func tapButton(named name: String, in element: XCUIElement? = nil) {
        let button = (element ?? self).buttons[name]
        if button.firstMatch.waitForExistence(timeout: 5) {
            button.tap()
        } else {
            XCTFail("No button named: \(name)")
        }
    }

    func tapImage(named name: String) {
        if images[name].firstMatch.waitForExistence(timeout: 5) {
            images[name].tap()
        } else {
            XCTFail("No image named: \(name)")
        }
    }

    func coordinate(at positon: CGVector) -> XCUICoordinate {
        coordinate(withNormalizedOffset: .zero).withOffset(positon)
    }

    func drag(from source: XCUICoordinate, to destination: XCUICoordinate) {
        source.press(forDuration: 0.1, thenDragTo: destination)
    }

    func tapBackButton() {
        navigationBars.buttons.element(boundBy: 0).tap()
    }

    func hideKeyboard() {
        keyboards.buttons.allElementsBoundByIndex.last?.tap()
    }
}

extension XCUIElement {
    var centerCoordinate: XCUICoordinate {
        coordinate(withNormalizedOffset: .init(dx: 0.5, dy: 0.5))
    }
}
