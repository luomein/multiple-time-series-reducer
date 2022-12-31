// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "multiple-time-series-reducer",
    platforms: [
      .iOS(.v16),
      .macOS(.v10_15),
      .tvOS(.v13),
      .watchOS(.v6),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "MultipleTimeSeriesReducer",
            targets: ["MultipleTimeSeriesReducer"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/pointfreeco/swift-case-paths", from: "0.10.0"),
        .package(url: "https://github.com/pointfreeco/swift-identified-collections", from: "0.4.1"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.47.2"),
        .package(url: "https://github.com/pointfreeco/swiftui-navigation", from: "0.4.5")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "MultipleTimeSeriesReducer",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "SwiftUINavigation", package: "swiftui-navigation"),
                .product(name: "IdentifiedCollections", package: "swift-identified-collections")
            ]),
        .testTarget(
            name: "MultipleTimeSeriesReducerTests",
            dependencies: ["MultipleTimeSeriesReducer"]),
    ]
)
