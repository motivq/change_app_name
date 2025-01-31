import 'dart:io';
import 'package:xml/xml.dart';
import './constants.dart';

class Utils {
  static Future<bool> fileExists(String path) async {
    return await File(path).exists();
  }

  static Future<void> checkRequiredFiles() async {
    var missingFiles = <String>[];

    if (!await fileExists(ANDROID_MANIFEST_PATH)) {
      missingFiles.add(ANDROID_MANIFEST_PATH);
    }

    if (!await fileExists(IOS_PROJECT_FILE)) {
      missingFiles.add(IOS_PROJECT_FILE);
    }

    if (missingFiles.isNotEmpty) {
      print('ERROR: The following required files are missing:');
      missingFiles.forEach((file) => print('  - $file'));
      print('\nRun "flutter create ." to regenerate missing files.');
      exit(1);
    }
  }

  static Future<void> updateAndroidManifestLabel(
      String path, String newName) async {
    if (!await fileExists(path)) {
      logWarning('Manifest file not found at $path');
      return;
    }

    final file = File(path);
    final document = XmlDocument.parse(await file.readAsString());

    var applications = document.findAllElements('application').toList();
    if (applications.isEmpty) {
      logError('No application tag found in $path');
      return;
    }

    // Update all application tags found (usually just one)
    for (var application in applications) {
      try {
        application.setAttribute('android:label', newName);
        logSuccess('Updated android:label in $path');
      } catch (e) {
        logError('Failed to update android:label in $path: $e');
      }
    }

    try {
      await file.writeAsString(document.toXmlString(pretty: true));
    } catch (e) {
      logError('Failed to write changes to $path: $e');
    }
  }

  static Future<void> updateIOSLauncherName(String newName) async {
    bool anyFileFound = false;

    for (String plistPath in IOS_PLIST_FILES) {
      if (await fileExists(plistPath)) {
        anyFileFound = true;
        await _updateSinglePlistFile(plistPath, newName);
        logSuccess('Updated launcher name in ${plistPath.split('/').last}');
      } else {
        logWarning('Plist file not found: ${plistPath.split('/').last}');
      }
    }

    if (!anyFileFound) {
      logError(
          'No iOS plist files found. Run "flutter create ." to regenerate missing files.');
      return;
    }

    logSuccess('Finished updating iOS launcher name');
  }

  static Future<void> _updateSinglePlistFile(
      String plistPath, String newName) async {
    try {
      final file = File(plistPath);
      final document = XmlDocument.parse(await file.readAsString());

      var dict = document.findAllElements('dict').first;
      var keys = dict.findElements('key').toList();

      bool displayNameFound = false;
      bool bundleNameFound = false;

      // First pass: update existing keys
      for (var key in keys) {
        switch (key.text) {
          case 'CFBundleDisplayName':
            var stringElement = key.nextElementSibling;
            if (stringElement != null) {
              stringElement.children.clear();
              stringElement.children.add(XmlText(newName));
              displayNameFound = true;
            }
            break;
          case 'CFBundleName':
            var stringElement = key.nextElementSibling;
            if (stringElement != null) {
              stringElement.children.clear();
              stringElement.children.add(XmlText(newName));
              bundleNameFound = true;
            }
            break;
        }
      }

      // Second pass: add missing keys
      if (!displayNameFound || !bundleNameFound) {
        if (!bundleNameFound) {
          dict.children.add(XmlElement(XmlName('key'))
            ..children.add(XmlText('CFBundleName')));
          dict.children.add(
              XmlElement(XmlName('string'))..children.add(XmlText(newName)));
        }

        if (!displayNameFound) {
          dict.children.add(XmlElement(XmlName('key'))
            ..children.add(XmlText('CFBundleDisplayName')));
          dict.children.add(
              XmlElement(XmlName('string'))..children.add(XmlText(newName)));
        }
      }

      await file.writeAsString(document.toXmlString(pretty: true));
      logSuccess('Updated ${plistPath.split('/').last}');
    } catch (e) {
      logError('Failed to update ${plistPath.split('/').last}: $e');
    }
  }

  static void logSuccess(String message) {
    print('✅ $message');
  }

  static void logError(String message) {
    print('❌ $message');
  }

  static void logWarning(String message) {
    print('⚠️ $message');
  }
}
