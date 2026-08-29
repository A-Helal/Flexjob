/// Application-wide runtime configuration.
///
/// Credentials and environment-specific values are injected at build time
/// via `--dart-define`:
///
///   flutter build apk \
///     --dart-define=BASE_URL=https://api.flexijobapp.com/api/ \
///     --dart-define=BASE_STORAGE_URL=https://api.flexijobapp.com/storage/ \
///     --dart-define=GUEST_EMAIL=guest@flexijobapp.com \
///     --dart-define=GUEST_PASSWORD=your_password_here
///
/// IMPORTANT: Never commit real credentials or production URLs in source code.
class AppConfig {
  AppConfig._();

  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://api.flexijobapp.com/api/',
  );

  static const String baseStorageUrl = String.fromEnvironment(
    'BASE_STORAGE_URL',
    defaultValue: 'https://api.flexijobapp.com/storage/',
  );

  static const String guestEmail = String.fromEnvironment(
    'GUEST_EMAIL',
    defaultValue: '',
  );

  static const String guestPassword = String.fromEnvironment(
    'GUEST_PASSWORD',
    defaultValue: '',
  );
}
