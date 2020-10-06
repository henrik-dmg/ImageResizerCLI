// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ImageResizerCLI",
    platforms: [
        .macOS(.v10_14)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .executable(
            name: "image-resizer",
            targets: ["ImageResizerCLI"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.0"),
        .package(url: "https://github.com/henrik-dmg/CLIFoundation", from: "0.4.0"),
        .package(url: "https://github.com/henrik-dmg/ImageResizer", from: "0.4.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "ImageResizerCLI",
            dependencies: ["ImageResizer", .product(name: "ArgumentParser", package: "swift-argument-parser"), "CLIFoundation"]
        ),
    ]
)
