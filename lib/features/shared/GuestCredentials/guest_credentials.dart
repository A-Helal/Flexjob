import 'package:flexiJobs/core/config/app_config.dart';

/// Guest account credentials.
///
/// Values are read from build-time dart-define flags so they are never
/// committed to source control.  Set them in your CI/CD pipeline or IDE
/// run configuration:
///
///   --dart-define=GUEST_EMAIL=guest@flexijobapp.com
///   --dart-define=GUEST_PASSWORD=your_password
@Deprecated(
  'Import AppConfig directly instead of using GuestCredentials. '
  'This class exists only for backward-compat and will be removed.',
)
abstract final class GuestCredentials {
  static String get email => AppConfig.guestEmail;
  static String get password => AppConfig.guestPassword;
}
