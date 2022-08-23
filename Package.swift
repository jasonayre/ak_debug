// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ak_debug",
    platforms: [
     .macOS(.v12),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/AudioKit/AudioKit.git", .branch("main")),
        // .package(url: "https://github.com/AudioKit/AudioKit.git", .exact("5.2.3")),
        .package(url: "https://github.com/AudioKit/DevoloopAudioKit.git", .branch("main")),
        .package(name: "SoundpipeAudioKit", url: "https://github.com/AudioKit/SoundpipeAudioKit/", .branch("main")),
        .package(url: "https://github.com/AudioKit/SporthAudioKit.git", from: "5.3.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "ak_debug",
            dependencies: ["AudioKit", "SoundpipeAudioKit", "SporthAudioKit", "DevoloopAudioKit"]),
        .testTarget(
            name: "ak_debugTests",
            dependencies: ["ak_debug"]),
    ]
)
