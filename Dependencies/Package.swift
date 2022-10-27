// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "Dependencies",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "Dependencies",
            targets: ["Dependencies"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apollographql/apollo-ios.git", .upToNextMinor(from: "0.53.0")),
    ],
    targets: [
        .target(
            name: "Dependencies",
            dependencies: [
                .product(name: "Apollo", package: "apollo-ios"),
            ]),
    ]
)
