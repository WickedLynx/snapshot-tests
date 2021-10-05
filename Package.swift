// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SnapshotTests",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SnapshotTests",
            targets: ["SnapshotTests"]),
    ],
    targets: [
        .target(
            name: "SnapshotTests",
            path: "Sources"),
        .testTarget(
            name: "SnapshotTestsTests",
            dependencies: ["SnapshotTests"]),
    ]
)
