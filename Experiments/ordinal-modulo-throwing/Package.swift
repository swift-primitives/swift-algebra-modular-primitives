// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "ordinal-modulo-throwing",
    platforms: [.macOS(.v26)],
    dependencies: [
        .package(path: "../../../swift-ordinal-primitives"),
        .package(path: "../../../swift-cardinal-primitives"),
        .package(path: "../../../swift-tagged-primitives"),
        .package(path: "../../../swift-finite-primitives"),
    ],
    targets: [
        .executableTarget(
            name: "ordinal-modulo-throwing",
            dependencies: [
                .product(name: "Ordinal Primitives", package: "swift-ordinal-primitives"),
                .product(name: "Cardinal Primitives", package: "swift-cardinal-primitives"),
                .product(name: "Tagged Primitives", package: "swift-tagged-primitives"),
                .product(name: "Finite Primitives", package: "swift-finite-primitives"),
            ],
            swiftSettings: [
                .enableUpcomingFeature("ExistentialAny"),
                .enableUpcomingFeature("InternalImportsByDefault"),
                .enableUpcomingFeature("MemberImportVisibility"),
                .enableExperimentalFeature("Lifetimes"),
                .strictMemorySafety()
            ]
        )
    ],
    swiftLanguageModes: [.v6]
)
