// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Currency",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "Currency",
            targets: ["Currency"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "4.9.1"))
    ],
    targets: [
        .target(
            name: "Currency",
            dependencies: ["Alamofire"]),
        .testTarget(
            name: "CurrencyTests",
            dependencies: ["Currency"],
            resources: [
                .copy("Resources"),
            ]),
    ]
)
