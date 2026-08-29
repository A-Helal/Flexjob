import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flexiJobs/core/network/api/network_apis_constants.dart';
import 'package:flexiJobs/core/app_data/data/models/response/app_user_response_model.dart';
import 'package:flexiJobs/core/app_data/data/models/response/governorate_response_model.dart';
import 'package:flexiJobs/core/app_data/data/models/response/job_category_response_model.dart';
import 'package:flexiJobs/core/app_data/domain/entities/app_user_entity.dart';
import 'package:flexiJobs/core/app_data/domain/entities/governorate_entity.dart';
import 'package:flexiJobs/core/app_data/domain/entities/job_category_entity.dart';
import 'package:flexiJobs/features/jobs/data/models/response/attachment_dto.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flexiJobs/core/di/dependency_init.dart';
import 'package:flexiJobs/core/firebase/firebase_messaging_service.dart';

// Secure-storage key constants to avoid magic strings
const String _kAuthToken = 'auth_token';
const String _kSecureEmail = 'es-email';
const String _kSecurePassword = 'es-password';

class LocalData {
  static final SharedPreferences _prefs = getIt<SharedPreferences>();
  static final FlutterSecureStorage _secure = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  // ── In-memory cache ──────────────────────────────────────────────────────
  static AppUserEntity? user;

  // ── Auth token (SecureStorage) ───────────────────────────────────────────

  /// Returns the stored JWT token.  Async because SecureStorage is async.
  static Future<String?> getToken() async {
    return _secure.read(key: _kAuthToken);
  }

  /// Persists the JWT token in encrypted storage.
  static Future<void> setToken(String token) async {
    await _secure.write(key: _kAuthToken, value: token);
  }

  /// Removes the JWT token from encrypted storage.
  static Future<void> deleteToken() async {
    await _secure.delete(key: _kAuthToken);
  }

  // ── Secure credentials ───────────────────────────────────────────────────

  static Future<void> setSecureEmail(String email) async {
    await _secure.write(key: _kSecureEmail, value: email);
  }

  static Future<void> setSecurePassword(String password) async {
    await _secure.write(key: _kSecurePassword, value: password);
  }

  static Future<String?> getSecuredEmail() => _secure.read(key: _kSecureEmail);

  static Future<String?> getSecuredPassword() =>
      _secure.read(key: _kSecurePassword);

  // ── Session / User data ──────────────────────────────────────────────────

  static Future<void> clearAllData() async {
    // Unsubscribe from Firebase topics before wiping session
    if (user?.id != null) {
      await FirebaseMessagingService().unsubscribeFromUserTopic(user!.id!);
    }

    await _secure.delete(key: _kAuthToken);
    await getIt<SessionManager>().remove('userInfo');
    user = null;
  }

  static Future<void> setUserInfo(AppUserEntity appUser) async {
    if (await getIt<SessionManager>().containsKey('userInfo')) {
      await getIt<SessionManager>().remove('userInfo');
    }
    await getIt<SessionManager>().set('userInfo', jsonEncode(appUser));
  }

  static Future<AppUserEntity> getUserInfo() async {
    final dynamic raw = await getIt<SessionManager>().get('userInfo');
    final Map<String, dynamic>? data = _decodeMap(raw);
    if (data == null) {
      await getIt<SessionManager>().remove('userInfo');
      throw const FormatException('Invalid cached userInfo');
    }
    return AppUserModel.fromJson(data);
  }

  // ── Governorates ─────────────────────────────────────────────────────────

  static Future<void> setGovernorates(
      List<GovernorateEntity> governorates) async {
    final SessionManager sm = getIt<SessionManager>();
    if (await sm.containsKey('governorats')) {
      await sm.remove('governorats');
    }
    await sm.set('governorats', jsonEncode(governorates));
  }

  static Future<List<GovernorateEntity>> getGovernorates() async {
    final dynamic raw = await getIt<SessionManager>().get('governorats');
    final List<dynamic> data = _decodeList(raw);
    return data
        .map((dynamic x) => GovernorateModel.fromJson(x as Map<String, dynamic>))
        .toList();
  }

  // ── Universities ─────────────────────────────────────────────────────────

  static Future<void> setUniversites(
      List<GovernorateEntity> universities) async {
    final SessionManager sm = getIt<SessionManager>();
    if (await sm.containsKey('universites')) {
      await sm.remove('universites');
    }
    await sm.set('universites', jsonEncode(universities));
  }

  static Future<List<GovernorateEntity>> getUniversites() async {
    final dynamic raw = await getIt<SessionManager>().get('universites');
    final List<dynamic> data = _decodeList(raw);
    return data
        .map((dynamic x) => GovernorateModel.fromJson(x as Map<String, dynamic>))
        .toList();
  }

  // ── Job categories ───────────────────────────────────────────────────────

  static Future<void> setJobCategories(
      List<JobCategoryEntity> jobsCategories) async {
    final SessionManager sm = getIt<SessionManager>();
    if (await sm.containsKey('jobsCategories')) {
      await sm.remove('jobsCategories');
    }
    await sm.set('jobsCategories', jsonEncode(jobsCategories));
  }

  static Future<List<JobCategoryEntity>> getJobCategories() async {
    final dynamic raw = await getIt<SessionManager>().get('jobsCategories');
    final List<dynamic> data = _decodeList(raw);
    return data
        .map((dynamic x) => JobCategoryModel.fromJson(x as Map<String, dynamic>))
        .toList();
  }

  // ── Profile image (SharedPreferences / base64) ───────────────────────────

  /// Downloads the user's profile picture from the server and caches it locally.
  /// This must be called explicitly; it is no longer a side-effect of setUserInfo.
  static Future<void> downloadAndSetProfileImage(AppUserEntity user) async {
    final String? relativePath = user.attachments
        ?.where((a) => a.type == 'profile_picture')
        .firstOrNull
        ?.path;
    if (relativePath == null) return;

    try {
      final Uri uri = Uri.parse('$baseStorageUrl$relativePath');
      final Dio dio = getIt<Dio>();
      final Response<List<int>> response = await dio.get<List<int>>(
        uri.toString(),
        options: Options(responseType: ResponseType.bytes),
      );
      if (response.statusCode == 200 && response.data != null) {
        final PlatformFile file = PlatformFile(
          name: 'profile_picture.jpg',
          size: response.data!.length,
          bytes: Uint8List.fromList(response.data!),
        );
        await setImageProfile(file);
      }
    } catch (_) {
      // Silently ignore download failures — non-critical UI enhancement
    }
  }

  /// Persists a profile image as base64 in SharedPreferences.
  /// Call this explicitly; no longer triggered implicitly from setUserInfo.
  static Future<void> setImageProfile(PlatformFile file) async {
    final Map<String, Object?> fileMap = <String, Object?>{
      'name': file.name,
      'size': file.size,
      'extension': file.extension,
      'path': file.path,
      'bytes': file.bytes != null ? base64Encode(file.bytes!) : null,
    };
    await _prefs.setString('profilePicture', jsonEncode(fileMap));
  }

  static Future<PlatformFile?> getImageProfile() async {
    final String? jsonString = _prefs.getString('profilePicture');
    if (jsonString == null) return null;
    final Map<String, dynamic> data =
        jsonDecode(jsonString) as Map<String, dynamic>;
    return PlatformFile(
      name: data['name'] as String,
      size: data['size'] as int,
      path: data['path'] as String?,
      bytes: data['bytes'] != null
          ? base64Decode(data['bytes'] as String)
          : null,
    );
  }

  // ── Preferences (SharedPreferences) ─────────────────────────────────────

  static bool? getIsDarkMode() => _prefs.getBool('isDarkMode');
  static Future<void> setIsDarkMode(bool isDarkMode) =>
      _prefs.setBool('isDarkMode', isDarkMode);

  static String? getLangCode() => _prefs.getString('LangCode');
  static Future<void> setLangCode(String langCode) =>
      _prefs.setString('LangCode', langCode);

  static bool? getFirstLogin() => _prefs.getBool('firstLogin');
  static Future<void> setFirstLogin() => _prefs.setBool('firstLogin', true);

  static Future<void> setFirstLoginWithInfo() =>
      _prefs.setBool('seFirstLoginWithIfo', true);
  static bool? getFirstLoginInfo() =>
      _prefs.getBool('seFirstLoginWithIfo');

  static bool getHasCompletedOnboarding() =>
      _prefs.getBool('hasCompletedOnboarding') ?? false;
  static Future<void> setHasCompletedOnboarding(bool value) =>
      _prefs.setBool('hasCompletedOnboarding', value);

  bool? getBool(String key) => _prefs.getBool(key);
  Future<bool> setBool(String key, bool value) => _prefs.setBool(key, value);

  Set<String> getKeys() => _prefs.getKeys();

  // ── Legacy compat — remove when callers are fully migrated ───────────────
  // Keep old method names temporarily so references continue to compile.
  // TODO: Remove after all call sites are updated.
  @Deprecated('Use setFirstLogin()')
  static Future<void> seFirstLogin() => setFirstLogin();

  @Deprecated('Use setFirstLoginWithInfo()')
  static Future<void> seFirstLoginWithIfo() => setFirstLoginWithInfo();

  @Deprecated('Use setJobCategories()')
  static Future<void> setJobCateGories(List<JobCategoryEntity> jobs) =>
      setJobCategories(jobs);

  @Deprecated('Use getJobCategories()')
  static Future<List<JobCategoryEntity>> getJobCateGories() =>
      getJobCategories();

  @Deprecated('Use setGovernorates()')
  static Future<void> setGovernorates2(
          List<GovernorateEntity> governorates) async =>
      setGovernorates(governorates);

  // Helper to get storage URL — used by LocalData callers that reference
  // ApiConstants directly.
  static String get baseStorageUrl => ApiConstants.baseStorageUrlProd;

  static Map<String, dynamic>? _decodeMap(dynamic raw) {
    if (raw is Map<String, dynamic>) return raw;
    if (raw is String && raw.isNotEmpty) {
      final dynamic decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) return decoded;
    }
    return null;
  }

  static List<dynamic> _decodeList(dynamic raw) {
    if (raw is List<dynamic>) return raw;
    if (raw is String && raw.isNotEmpty) {
      final dynamic decoded = jsonDecode(raw);
      if (decoded is List<dynamic>) return decoded;
    }
    return <dynamic>[];
  }
}
