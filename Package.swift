// swift-tools-version:5.0
/*
 |  _   ____   ____   _
 | ⎛ |‾|  ⚈ |-| ⚈  |‾| ⎞
 | ⎝ |  ‾‾‾‾| |‾‾‾‾  | ⎠
 |  ‾        ‾        ‾
 */

import PackageDescription

let package = Package(
    name: "SharedHelpers",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "SharedHelpers", targets: ["SharedHelpers"])
    ],
    targets: [
        .target(name: "SharedHelpers", path: "Sources")
    ],
    swiftLanguageVersions: [.v5]
)
