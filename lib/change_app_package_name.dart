library change_app_package_name;

import './android_rename_steps.dart';
import './ios_rename_steps.dart';
import './utils.dart';
import './constants.dart';

class ChangeAppPackageName {
  static Future<void> start(List<String> arguments) async {
    // Support for legacy positional arguments
    if (arguments.isNotEmpty && !arguments[0].startsWith('--')) {
      await _handleLegacyArguments(arguments);
      return;
    }

    // Parse named arguments
    String? packageName;
    String? launcherName;
    bool? androidOnly;
    bool? iosOnly;

    for (int i = 0; i < arguments.length; i++) {
      switch (arguments[i]) {
        case '--package-name':
          if (i + 1 < arguments.length) packageName = arguments[++i];
          break;
        case '--launcher-name':
          if (i + 1 < arguments.length) launcherName = arguments[++i];
          break;
        case '--android':
          androidOnly = true;
          break;
        case '--ios':
          iosOnly = true;
          break;
      }
    }

    if (packageName == null && launcherName == null) {
      Utils.logError('No package name or launcher name provided.');
      print(USAGE_MESSAGE);
      return;
    }

    // Determine which platforms to update
    bool updateAndroid =
        androidOnly == true || (androidOnly != true && iosOnly != true);
    bool updateIos =
        iosOnly == true || (androidOnly != true && iosOnly != true);

    // Process package name changes first if provided
    if (packageName != null) {
      Utils.logSuccess('Starting package name update to: $packageName');

      if (updateAndroid) {
        await AndroidRenameSteps(packageName).process();
      }
      if (updateIos) {
        await IosRenameSteps(packageName).process();
      }
    }

    // Then process launcher name changes if provided
    if (launcherName != null) {
      Utils.logSuccess('Starting launcher name update to: $launcherName');

      if (updateAndroid) {
        await AndroidRenameSteps.updateLauncherName(launcherName);
      }
      if (updateIos) {
        await IosRenameSteps.updateLauncherName(launcherName);
      }
    }

    Utils.logSuccess('All requested changes completed successfully!');
  }

  static Future<void> _handleLegacyArguments(List<String> arguments) async {
    if (arguments.length == 1) {
      Utils.logSuccess(
          'Using legacy mode: updating package name for both platforms');
      await _renameBoth(arguments[0]);
    } else if (arguments.length == 2) {
      var platform = arguments[1].toLowerCase();
      if (platform == '--android') {
        Utils.logSuccess(
            'Using legacy mode: updating package name for Android only');
        await AndroidRenameSteps(arguments[0]).process();
      } else if (platform == '--ios') {
        Utils.logSuccess(
            'Using legacy mode: updating package name for iOS only');
        await IosRenameSteps(arguments[0]).process();
      } else {
        Utils.logError('Invalid argument. Use "--android" or "--ios".');
        print(USAGE_MESSAGE);
      }
    }
  }

  static Future<void> _renameBoth(String newPackageName) async {
    await AndroidRenameSteps(newPackageName).process();
    await IosRenameSteps(newPackageName).process();
  }
}
