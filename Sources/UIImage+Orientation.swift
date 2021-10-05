import UIKit

extension UIImage {
    func imageWithoutOrientation() -> UIImage? {
        // Redraw the image to fix the orientation
        UIGraphicsBeginImageContextWithOptions(self.size, true, scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: self.size))
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}
