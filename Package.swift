import PackageDescription

let package = Package(
    name: "RomeKit",
    dependencies: [
        .Package(url: "https://github.com/146BC/Alamofire.git", "4.0.2"),
        .Package(url: "https://github.com/Hearst-DD/ObjectMapper.git",
            majorVersion: 2, minor: 2),
    ]
)
