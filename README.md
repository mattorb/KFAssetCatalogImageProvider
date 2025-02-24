# KFAssetCatalogImageProvider

A Swift package that extends Kingfisher to support loading images from Asset Catalogs using a custom URL scheme. 

# Why would you want this?

This is particularly useful for SwiftUI previews when you want to use local image assets from the 'Preview Content' image catalog.  Your image locator (a URL) provided by any sample data can now refer to local Preview Only image resources, retaining KFImage usage&behaviors (placeholder, etc), and ensuring those images are not bundled into a release app version. 

## Requirements

- iOS 16.0+ / macOS 11.0+
- Swift 5.9+
- [Kingfisher](https://github.com/onevcat/Kingfisher) 8.0+

## Usage

The package implements a custom URL scheme `asset-catalog://` with a custom `KFImage` initializer.  

```swift
import SwiftUI
import Kingfisher
import KFAssetCatalogImageProvider

struct ContentView: View {
    var body: some View {
        KFImage(smartURL: URL(string: "asset-catalog://image_name.jpg")!)
            .placeholder { _ in
                ProgressView()
            }
            .resizable()
            .scaledToFit()
    }
}
```


### Full Example
If you pass in a scheme of `file://` or `https://` that still works with the new initializer. 

[Example Project](https://github.com/mattorb/KFAssetCatalogImageProviderExample)
![CleanShot 2025-02-20 at 10 39 04@2x](https://github.com/user-attachments/assets/8840c325-a115-4356-8fd6-7497e73adaa3)


### URL Format

- Basic usage: `asset-catalog://image_name.ext`
- With simulated delay: `asset-catalog://image_name.ext?delay=3` (3 seconds)

The delay parameter is particularly useful for testing loading states in SwiftUI previews.

## Features

- Load images from [Preview Content] Asset Catalog using Kingfisher
- Support for simulated network delays
- Retains Kingfisher's placeholder and error handling capabilities
- SwiftUI preview friendly

## License

This project is licensed under the MIT License - see the LICENSE file for details.
