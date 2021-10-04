import Foundation
import UIKit
import CoreImage

extension UIImage {
    var asFilterInput: CIImage? {
        guard let cgImage = cgImage else { return nil}
        return CIImage(cgImage: cgImage)
    }

    func matches(_ otherImage: UIImage) -> (Bool, UIImage?) {
        guard let difference = otherImage.difference(self),
            let differenceCGImage = difference.asFilterOutput else { return (false, nil) }
        let differenceImage = UIImage(cgImage: differenceCGImage)
        let averageFilter = AreaAverageFilter(inputImage: difference)
        guard let averageColor = averageFilter.outputImage?.asFilterOutput?.firstPixelColor else { return (false, differenceImage) }
        return (averageColor.resemblesBlack, differenceImage)
    }

    func difference(_ otherImage: UIImage) -> CIImage? {
        guard let inputImage = asFilterInput, let inputBackgroundImage = otherImage.asFilterInput else { return nil }
        let differenceFilter = DifferenceFilter(inputImage: inputImage, inputBackgroundImage: inputBackgroundImage)
        return differenceFilter.outputImage
    }

    func croppedWith(insets: UIEdgeInsets) -> UIImage? {
        guard let ciImage = asFilterInput else { return nil }
        let extent = ciImage.extent
        let target = CGRect(x: extent.origin.x + insets.left, y: extent.origin.y + insets.top, width: extent.width - insets.left - insets.right, height: extent.height - insets.top - insets.bottom)
        guard let output = ciImage.cropped(to: target).asFilterOutput else { return nil }
        return UIImage(cgImage: output)
    }
}

extension CIImage {
    var asFilterOutput: CGImage? {
        let context = CIContext(options: nil)
        return context.createCGImage(self, from: extent)
    }
}

extension CGImage {
    var firstPixelColor: UIColor? {
        guard let pixelData = dataProvider?.data else { return nil }
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        let r = CGFloat(data[0]) / CGFloat(255.0)
        let g = CGFloat(data[1]) / CGFloat(255.0)
        let b = CGFloat(data[2]) / CGFloat(255.0)
        let a = CGFloat(data[3]) / CGFloat(255.0)
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}

extension UIColor {
    var resemblesBlack: Bool {
        let tolerance = Double.ulpOfOne
        var red: CGFloat = 255
        var green: CGFloat = 255
        var blue: CGFloat = 255
        guard getRed(&red, green: &green, blue: &blue, alpha: nil) else { return false }
        return [red, green, blue].filter { Double($0) >= tolerance }.count == 0
    }
}

struct DifferenceFilter {
    let name = "CISubtractBlendMode"
    let inputImage: CIImage
    let inputBackgroundImage: CIImage
    var outputImage: CIImage? {
        let filter = CIFilter(name: name, parameters: ["inputImage" : inputImage, "inputBackgroundImage" : inputBackgroundImage])
        return filter?.outputImage
    }
}

struct AreaAverageFilter {
    let name = "CIAreaAverage"
    let inputImage: CIImage
    var outputImage: CIImage? {
        let extent = CIVector(cgRect: inputImage.extent)
        let filter = CIFilter(name: name, parameters: ["inputImage" : inputImage, "inputExtent" : extent])
        return filter?.outputImage
    }
}
