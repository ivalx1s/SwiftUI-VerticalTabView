// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "SwiftUI-VerticalTabView",
	platforms: [
		.iOS(.v15)
	],
    products: [
        .library(
            name: "SwiftUI-VerticalTabView",
            targets: ["SwiftUI-VerticalTabView"]
		),
    ],
    targets: [
        .target(
            name: "SwiftUI-VerticalTabView"
		),
    ]
)
