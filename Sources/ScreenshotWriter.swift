import Foundation
import UIKit

struct ScreenshotWriter {
    let folderName: String

    init(folderName: String = "UITests") {
        self.folderName = folderName
    }

    func saveDirectoryPath() -> String? {
        let path = NSHomeDirectory() + "/Screenshots/\(folderName)/"
        guard !FileManager.default.fileExists(atPath: path) else { return path }
        do {
            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            print("********************************")
            print("Screenshot Directory")
            print(path)
            print("********************************")
            return path
        } catch {
            return nil
        }
    }

    func clear() {
        guard let folderPath = saveDirectoryPath() else { return }
        try? FileManager.default.removeItem(atPath: folderPath)
    }

    func save(screenshot: UIImage, named name: String) {
        guard let folderPath = saveDirectoryPath(),
            let data = screenshot.pngData() else { return }
        let url = URL(fileURLWithPath: "\(folderPath)/\(name).png")
        try? data.write(to: url)
    }
}
