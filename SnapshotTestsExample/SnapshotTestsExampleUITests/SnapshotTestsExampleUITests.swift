//
//  SnapshotTestsExampleUITests.swift
//  SnapshotTestsExampleUITests
//
//  Created by Harshad Dange on 04/10/2021.
//

import XCTest

class SnapshotTestsExampleUITests: TestCaseBase {
    func testSlider() {
        createUITest(name: "Slider")
            .run([
                {
                  $0.tap()
                }
            ])
    }
}
