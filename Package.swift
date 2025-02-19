// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "KFAssetCatalogImageProvider",
    platforms: [
        .iOS(.v16),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "KFAssetCatalogImageProvider",
            targets: ["KFAssetCatalogImageProvider"]),
    ],
    dependencies: [
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "8.0.0")
    ],
    targets: [
        .target(
            name: "KFAssetCatalogImageProvider",
            dependencies: ["Kingfisher"])
    ]
)
