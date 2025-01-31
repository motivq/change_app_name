# Enhanced App Package Name & Display Name Changer for Flutter

This is an enhanced fork of [change_app_package_name](https://github.com/atiqsamtia/change_app_package_name) by Atiq Samtia, adding support for changing app launcher display names and using named arguments.

## What's New?
- [x] Change app launcher display name (what users see on their device)
- [x] Support for named arguments for better clarity
- [x] Ability to change package name and launcher name in a single command
- [x] Maintains backward compatibility with original command format

## Original Features
- [x] Update AndroidManifest.xml files for release, debug & profile
- [x] Update build.gradle file
- [x] Update MainActivity file (both Java & Kotlin supported)
- [x] Move MainActivity file to new package directory structure
- [x] Delete old package name directory structure
- [x] Update Product Bundle Identifier in iOS
- [x] Platform-specific updates (Android or iOS only)

## Installation

Add to your `pubspec.yaml` in `dev_dependencies:` section:
```yaml
dev_dependencies: 
  change_app_name: ^1.0.0
```

Or run:
```bash
flutter pub add -d change_app_name
```

## Usage

### Using Named Arguments (New)

#### Change Package Name Only

For all platforms:
```bash
dart run change_app_name:main --package-name com.new.package.name
```

For Android only:
```bash
dart run change_app_name:main --package-name com.new.package.name --android
```

For iOS only:
```bash
dart run change_app_name:main --package-name com.new.package.name --ios
```

#### Change Launcher Name Only

For all platforms:
```bash
dart run change_app_name:main --launcher-name "My New App Name"
```

For Android only:
```bash
dart run change_app_name:main --launcher-name "My New App Name" --android
```

For iOS only:
```bash
dart run change_app_name:main --launcher-name "My New App Name" --ios
```

#### Change Both Package Name and Launcher Name

For all platforms:
```bash
dart run change_app_name:main --package-name com.new.package.name --launcher-name "My New App Name"
```

For Android only:
```bash
dart run change_app_name:main --package-name com.new.package.name --launcher-name "My New App Name" --android
```

For iOS only:
```bash
dart run change_app_name:main --package-name com.new.package.name --launcher-name "My New App Name" --ios
```

### Legacy Mode (Original Syntax)
Still supports the original command format for package name changes:

For all platforms:
```bash
dart run change_app_name:main com.new.package.name
```

For Android only:
```bash
dart run change_app_name:main com.new.package.name --android
```

For iOS only:
```bash
dart run change_app_name:main com.new.package.name --ios
```

## Notes
- For iOS: If you have customized CFBundleIdentifier in Info.plist, it will not be updated automatically. You'll need to update it manually.
- The launcher name change updates:
  - Android: `android:label` in AndroidManifest.xml (main, debug, and profile variants)
  - iOS: `CFBundleDisplayName` and `CFBundleName` in Info.plist files (main, debug, and release variants)
- When changing both package name and launcher name in a single command, the package name is updated first, followed by the launcher name
- The tool will show progress with emoji indicators (✅ success, ⚠️ warning, ❌ error)

## Credits

This package is based on [change_app_package_name](https://github.com/atiqsamtia/change_app_package_name) by Atiq Samtia. The original package provided the foundation for package name changing functionality.

## Contributing

1. Fork it (<https://github.com/motivq/change_app_name/fork>)
2. Create your feature branch (`git checkout -b feature/amazing_feature`)
3. Commit your changes (`git commit -am 'Add some amazing_feature'`)
4. Push to the branch (`git push origin feature/amazing_feature`)
5. Create a new Pull Request

## License

Distributed under the MIT license, same as the original package.
