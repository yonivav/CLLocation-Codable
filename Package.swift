// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "CLLocationWrapper",
    platforms: [
        .iOS(.v10), .watchOS(.v3), .macOS(.v10_15), .tvOS(.v10),
    ],
    products: [
        .library(name: "CLLocationWrapper", targets: ["CLLocationWrapper"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(name: "CLLocationWrapper",
                dependencies: []),
        .testTarget(name: "CLLocationWrapperTests",
                    dependencies: ["CLLocationWrapper"]),
    ]
)
