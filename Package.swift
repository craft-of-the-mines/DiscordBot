// swift-tools-version:4.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DuetBot",
    dependencies: [
	.package(url: "https://github.com/Azoy/Sword", .branch("master")),
  .package(url: "https://github.com/craft-of-the-mines/Raptor", .branch("master"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "DuetBot",
            dependencies: ["Sword", "Raptor"]),
        .testTarget(
            name: "DuetBotTests",
            dependencies: ["DuetBot"]),
    ]
)
