// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "SwiftyString",
    targets: [
        .target(name: "SwiftyString"),
        .testTarget(name: "SwiftyStringTests", dependencies: ["SwiftyString"])
    ]
)
