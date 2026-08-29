import 'package:dio/dio.dart';
import 'package:flexiJobs/core/config/app_config.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Registers third-party dependencies with get_it/injectable.
///
/// The base URL is controlled at build time via `--dart-define=BASE_URL=...`
/// rather than being hardcoded here.  This ensures the same codebase can
/// target dev, staging, and production without source-level changes.
@module
abstract class RegisterModule {
  @Named('BaseUrl')
  String get baseUrl => AppConfig.baseUrl;

  @preResolve
  @singleton
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  Dio dio(@Named('BaseUrl') String url) => Dio(
        BaseOptions(
          baseUrl: url,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 60),
          sendTimeout: const Duration(seconds: 60),
        ),
      );

  @preResolve
  @singleton
  Future<SessionManager> get sessionManager async => SessionManager();
}
