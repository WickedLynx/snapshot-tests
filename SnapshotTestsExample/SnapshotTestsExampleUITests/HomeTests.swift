//
//  SnapshotTestsExampleUITests.swift
//  SnapshotTestsExampleUITests
//
//  Created by Harshad Dange on 04/10/2021.
//

import XCTest
import SnapshotTests

class HomeTests: SnapshotTestCase {
    var statusBarCropInsets: UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 40 * UIScreen.main.scale, right: 0)
    }

    func testSlider() {
        let test = createUITest(name: "Slider", croppingInsets: statusBarCropInsets)
        test.run([
            {
              $0.wait()
            },
            {
              $0.sliders["slider"].adjust(toNormalizedSliderPosition: 0.5)
            },
            {
              $0.sliders["slider"].adjust(toNormalizedSliderPosition: 0.9)
            },
            {
              $0.sliders["slider"].adjust(toNormalizedSliderPosition: 0.1)
            }
        ])
    }

    func testReset() {
        let test = createUITest(name: "Reset", croppingInsets: statusBarCropInsets)
        test.run([
            {
              $0.sliders["slider"].adjust(toNormalizedSliderPosition: 0.5)
            },
            {
              $0.tapButton(named: "reset button", in: nil)
            }
        ])
    }
}
