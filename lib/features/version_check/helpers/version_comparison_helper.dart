import 'dart:io';
import 'dart:math';
import 'package:flexiJobs/features/shared/common_utils/log_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flexiJobs/features/version_check/domain/entities/app_version_entity.dart';

enum UpdateType {
  none, // No update needed
  optional, // Update available but not critical (can be cancelled)
  mandatory, // Critical update required (cannot be cancelled)
}

class VersionComparisonHelper {
  /// Compares current app version with server versions
  /// Returns UpdateType based on the comparison
  static Future<UpdateType> checkUpdateRequired(
    AppVersionEntity versionEntity,
  ) async {
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = int.tryParse(packageInfo.buildNumber) ?? 0;

    int? latestVersion;
    int? criticalVersion;

    // Get platform-specific versions
    if (Platform.isAndroid) {
      latestVersion = versionEntity.androidVersion;
      criticalVersion = versionEntity.androidCriticalVersion;
    } else if (Platform.isIOS) {
      latestVersion =versionEntity.iosVersion;
      criticalVersion = versionEntity.iosCriticalVersion;
    }

    // If no version data available, no update needed
    if (latestVersion == null || criticalVersion == null) {
      return UpdateType.none;
    }

    // If current version is already the latest, no update needed
    if (currentVersion >= latestVersion) {
      return UpdateType.none;
    }

    // If current version is less than critical version, mandatory update
    if (currentVersion < criticalVersion) {
      return UpdateType.mandatory;
    }



    // If current version is >= critical but < latest, optional update
    return UpdateType.optional;
  }

  /// Gets the store URL based on platform
  static String getStoreUrl() {
    if (Platform.isAndroid) {
      return 'https://play.google.com/store/apps/details?id=com.flexi.jobs.flexi_jobs';
    } else if (Platform.isIOS) {
      return 'https://apps.apple.com/app/flexijob/id6535647074';   }
    return '';
  }
}
