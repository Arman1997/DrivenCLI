// swift-tools-version: 5.7.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DrivenCLI",
    platforms: [
        .macOS(.v10_15)
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.3.0"),
        .package(url: "https://github.com/Arman1997/Driven", branch: "master"),
        .package(url: "https://github.com/Arman1997/DeclarativeSwiftSyntax", branch: "master"),
        .package(url: "https://github.com/jpsim/Yams.git", from: "5.0.6")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "DrivenCLI",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Driven", package: "Driven"),
                .product(name: "DeclarativeSwiftSyntax", package: "DeclarativeSwiftSyntax"),
                .product(name: "Yams", package: "Yams")
            ]
        ),
    ]
)
