// swift-tools-version: 6.3.1

import PackageDescription

let package = Package(
    name: "swift-algebra-modular-primitives",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26)
    ],
    products: [
        .library(
            name: "Algebra Modular Primitives",
            targets: ["Algebra Modular Primitives"]
        ),
        .library(
            name: "Algebra Modular Primitives Test Support",
            targets: ["Algebra Modular Primitives Test Support"]
        ),
    ],
    dependencies: [
        .package(path: "../swift-affine-primitives"),
        .package(path: "../swift-algebra-field-primitives"),
        .package(path: "../swift-finite-primitives"),
        .package(path: "../swift-identity-primitives"),
    ],
    targets: [
        .target(
            name: "Algebra Modular Primitives",
            dependencies: [
                .product(name: "Affine Primitives", package: "swift-affine-primitives"),
                .product(name: "Algebra Field Primitives", package: "swift-algebra-field-primitives"),
                .product(name: "Finite Primitives", package: "swift-finite-primitives"),
                .product(name: "Identity Primitives", package: "swift-identity-primitives"),
            ]
        ),
        .target(
            name: "Algebra Modular Primitives Test Support",
            dependencies: [
                "Algebra Modular Primitives",
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Algebra Modular Primitives Tests",
            dependencies: [
                "Algebra Modular Primitives",
                "Algebra Modular Primitives Test Support",
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
