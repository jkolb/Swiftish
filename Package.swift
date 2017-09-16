// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Swiftish",
    products: [
        .library(name: "Swiftish", targets: ["Swiftish"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "Swiftish", dependencies: []),
        .testTarget(name: "SwiftishTests", dependencies: ["Swiftish"]),
    ]
)
