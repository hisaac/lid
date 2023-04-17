// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "lid",
    platforms: [.macOS(.v12)],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.2.0"),
        .package(url: "https://github.com/jpsim/Yams.git", from: "5.0.5"),
        // TODO: Use https://github.com/jkandzi/Progress.swift for download progress bar
    ],
    targets: [
        .executableTarget(
            name: "lid",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "Yams",
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "lidTests",
            dependencies: ["lid"],
            path: "Tests",
            resources: [.copy("test-manifest.yml")]
        )
    ]
)
