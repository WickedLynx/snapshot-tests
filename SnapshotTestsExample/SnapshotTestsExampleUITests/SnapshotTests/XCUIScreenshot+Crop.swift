import Foundation
import XCTest

extension XCUIScreenshot {
    func croppingTopToolbar() -> UIImage {
        let toolbarHeight = 87 * UIScreen.main.scale
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: toolbarHeight, right: 0)
        return image.imageWithoutOrientation()?.croppedWith(insets: insets) ?? image
    }

    func cropped(with insets: UIEdgeInsets) -> UIImage {
        image.imageWithoutOrientation()?.croppedWith(insets: insets) ?? image
    }
}
