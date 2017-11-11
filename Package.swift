// swift-tools-version:4.0

import PackageDescription

let package = Package(
	name: "RomeKit",
	products: [
		.library(name: "RomeKit", targets: ["RomeKit"]),
		],
	dependencies: [],
	targets: [
		.target(name: "RomeKit", dependencies: []),
		.testTarget(name: "RomeKitTests", dependencies: ["RomeKit"]),
		]
)
