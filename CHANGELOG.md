## [1.0.0] - (March 15, 2024)

This is a fork of [change_app_package_name](https://github.com/atiqsamtia/change_app_package_name) with significant enhancements:

### Added
- Support for changing app launcher display name
- Named arguments for better command clarity
- Ability to change both package name and launcher name in a single command
- Support for all iOS Info.plist variants (main, debug, release)
- Improved error handling and user feedback with emoji indicators
- Comprehensive test suite

### Changed
- Migrated to XML parsing for more reliable file updates
- Improved handling of missing files and error conditions
- Enhanced logging with clear success/warning/error indicators
- Updated documentation with detailed usage examples

### Maintained
- Backward compatibility with original command format
- Support for platform-specific updates (Android/iOS)
- All original package name changing functionality

## Previous Versions (Original Package)

## [1.4.0] - (September 20, 2024)

* Specify which platform they want to rename the package for. Thanks [@moha-b](moha-b) #43

## [1.3.0] - (July 08, 2024)

* iOS support added

## [1.2.0] - (Jun 03, 2024)

* Support Flutter 3.22.0
* Fix regex to only replace package name in manifest files
* Fix #26 where kotlin directory does not exist so it should not throw error.
* add extra check to make sure the old application id is found before proceeding to next steps.

## [1.1.0] - (April 08, 2021)

* Change MainActivity mechanism to handle different locations.

## [1.0.0] - (April 08, 2021)

* Added null safety.

## [0.1.3] - (April 08, 2021)

* Add extra Files checks. Hopefully fixes #7

## [0.1.2] - (March 16, 2020)

* Bug Fix in README.md

## [0.1.1] - (March 16, 2020)

* Update code as per pub.dev guidelines

## [0.1.0] - (March 16, 2020)

* Change Android Package Name with single command
