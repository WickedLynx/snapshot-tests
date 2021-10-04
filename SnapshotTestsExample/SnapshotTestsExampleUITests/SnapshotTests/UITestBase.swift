import XCTest

class TestCaseBase: XCTestCase {
    var app: XCUIApplication!

    override var name: String { String(describing: type(of: self)) }

    override func setUpWithError() throws {
        continueAfterFailure = true
        let app = XCUIApplication()
        self.app = app
        app.launch()
    }
}

extension TestCaseBase {
    class UITest {
        private let name: String
        private let testCase: XCTestCase
        private let app: XCUIApplication
        private let screenshotWriter: ScreenshotWriter
        private let window: XCUIElement
        let imageCroppingInsets: UIEdgeInsets

        init(name: String, testCase: XCTestCase, app: XCUIApplication, croppingInsets: UIEdgeInsets = .zero) {
            self.name = name
            self.testCase = testCase
            self.app = app
            self.window = app.windows.firstMatch
            let screenshotPath = "\(testCase.name)/\(name)"
            self.screenshotWriter = ScreenshotWriter(folderName: screenshotPath)
            self.imageCroppingInsets = croppingInsets
        }

        func run(_ steps: [(XCUIApplication) -> ()]) {
            screenshotWriter.clear()
            steps.enumerated().forEach { (i, step) in
                let currentStep = i + 1
                step(app)
                testCase.wait(for: 0.1)
                testCase.assertScreenshotsMatch(
                    result: resultImage(),
                    expected: expectedImage(at: currentStep),
                    message: "Result does not match expected image for '\(imageName(at: currentStep))'",
                    prefix: imageName(at: currentStep),
                    screenshotWriter: screenshotWriter
                )
            }
        }

        private func imageName(at step: Int) -> String {
            return "\(name)-step\(step)"
        }

        private func resultImage() -> UIImage {
            return window.screenshot().cropped(with: imageCroppingInsets)
        }

        private func expectedImage(at step: Int) -> UIImage? {
            let imagePath = Bundle(for: type(of: self)).resourceURL?
                .appendingPathComponent("ReferenceScreenshots")
                .appendingPathComponent(testCase.name)
                .appendingPathComponent(name)
                .appendingPathComponent("\(imageName(at: step))-expected")
                .appendingPathExtension("png")

            guard
                let path = imagePath,
                let imageData = try? Data(contentsOf: path)
            else { return nil }

            let image = UIImage(data: imageData)
            guard let referenceImage = image else {
                return nil
            }
            return referenceImage.imageWithoutOrientation()
        }
    }

    func createUITest(name: String, croppingInsets: UIEdgeInsets = .zero) -> UITest {
        return UITest(name: name, testCase: self, app: app, croppingInsets: croppingInsets)
    }
}
