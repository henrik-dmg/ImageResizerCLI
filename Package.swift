// swift-tools-version:6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ImageUtil",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .executable(
            name: "imageutil",
            targets: ["ImageUtil"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
        .package(url: "https://github.com/henrik-dmg/CLIFoundation", from: "0.4.0"),
        .package(url: "https://github.com/henrik-dmg/HPImageUtils", branch: "main")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .executableTarget(
            name: "ImageUtil",
            dependencies: [
				.product(name: "HPImageUtils", package: "HPImageUtils"),
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
				"CLIFoundation"
			]
        ),
    ]
)
