/// File paths for Android
const String ANDROID_MANIFEST_PATH = 'android/app/src/main/AndroidManifest.xml';
const String ANDROID_MANIFEST_DEBUG =
    'android/app/src/debug/AndroidManifest.xml';
const String ANDROID_MANIFEST_PROFILE =
    'android/app/src/profile/AndroidManifest.xml';

/// File paths for iOS
const String IOS_PROJECT_FILE = 'ios/Runner.xcodeproj/project.pbxproj';
const String IOS_INFO_PLIST = 'ios/Runner/Info.plist';
const String IOS_INFO_DEBUG_PLIST = 'ios/Runner/Info-Debug.plist';
const String IOS_INFO_RELEASE_PLIST = 'ios/Runner/Info-Release.plist';

const List<String> IOS_PLIST_FILES = [
  IOS_INFO_PLIST,
  IOS_INFO_DEBUG_PLIST,
  IOS_INFO_RELEASE_PLIST,
];

/// Help message for CLI
const String USAGE_MESSAGE = '''
Usage:
  Named arguments mode:
    dart run change_app_package_name:main --package-name <new.package.name> [--android|--ios]
    dart run change_app_package_name:main --launcher-name "New App Name" [--android|--ios]
    
  Legacy mode:
    dart run change_app_package_name:main <new.package.name> [--android|--ios]

Options:
  --package-name    New package name for the app
  --launcher-name   New launcher name for the app
  --android        Apply changes only to Android
  --ios           Apply changes only to iOS
''';
