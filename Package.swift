// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DCNFCFramework",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "DCNFCFramework",
            targets: ["DCNFCFramework"]),
    ],
//    targets: [
//        // Targets are the basic building blocks of a package, defining a module or a test suite.
//        // Targets can depend on other targets in this package and products from dependencies.
//        .target(
//            name: "DCNFCFramework"),
//        .testTarget(
//            name: "DCNFCFrameworkTests",
//            dependencies: ["DCNFCFramework"]),
//    ]
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
//        .target(
//            name: "DCNFCFramework",
//            dependencies: []),
//        .testTarget(
//            name: "DCNFCFrameworkTests",
//            dependencies: ["DCNFCFramework"]),
        .binaryTarget(name: "DCNFCFramework", path: "./Sources/DCNFCFramework.xcframework")
    ]
)
