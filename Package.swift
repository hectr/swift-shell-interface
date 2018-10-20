// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "ShellInterface",
    products: [
        .library(
            name: "ShellInterface",
            targets: ["ShellInterface"]),
        ],
    dependencies: [
        ],
    targets: [
        .target(
            name: "ShellInterface",
            dependencies: []),
        
        .testTarget(
            name: "ShellInterfaceTests",
            dependencies: ["ShellInterface"]),
        ]
)
