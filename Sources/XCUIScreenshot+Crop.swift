import Foundation
import XCTest

extension XCUIScreenshot {
    func cropped(with insets: UIEdgeInsets) -> UIImage {
        image.imageWithoutOrientation()?.croppedWith(insets: insets) ?? image
    }
}
