import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/core/routing/routes.dart';
import 'package:flexiJobs/core/routing/routes.gr.dart';
import 'package:flutter/foundation.dart';

import 'package:flexiJobs/core/helpers/view_toolbox.dart';
import 'package:flexiJobs/core/di/dependency_init.dart';
import 'package:flexiJobs/core/utils/log_utils.dart';
import 'package:flexiJobs/features/shared/data/local_data.dart';

/// Injects auth headers (Bearer token, locale, Content-Type) into every request
/// and handles 401 / 429 globally.
class AuthInterceptor extends Interceptor {
  static bool _isRedirectingToLogin = false;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';
    options.headers['Connection'] = 'keep-alive';

    // Null-safe locale fallback — navigatorKey may not have a context yet on
    // the very first request that fires during startup.
    final String? langCode = getIt<AppRouter>()
        .navigatorKey
        .currentContext
        ?.locale
        .languageCode;
    options.headers['lang'] = langCode ?? 'en';

    final String? token = await LocalData.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Connection / timeout — dismiss loading and propagate
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      ViewsToolbox.dismissLoading();
      handler.next(err);
      return;
    }

    // No network connectivity — dismiss loading and propagate
    final List<ConnectivityResult> connectivity =
        await Connectivity().checkConnectivity();
    if (connectivity.isNotEmpty &&
        connectivity.every((ConnectivityResult result) => result == ConnectivityResult.none)) {
      ViewsToolbox.dismissLoading();
      handler.next(err);
      return;
    }

    // 429 Too Many Requests — single retry with a brief back-off.
    // Uses a fresh Options object so we do not mutate the shared Dio instance.
    if (err.response?.statusCode == 429) {
      try {
        await Future<void>.delayed(const Duration(seconds: 1));
        final Response<dynamic> retried = await getIt<Dio>().fetch(
          err.requestOptions.copyWith(
            headers: Map<String, dynamic>.from(err.requestOptions.headers),
          ),
        );
        handler.resolve(retried);
      } catch (e) {
        handler.next(err);
      }
      return;
    }

    // 401 Unauthorized — clear session and redirect to login
    if (err.response?.statusCode == 401) {
      await LocalData.clearAllData();
      ViewsToolbox.dismissLoading();
      if (!_isRedirectingToLogin) {
        _isRedirectingToLogin = true;
        await CustomMainRouter.appRouter.replaceAll(<PageRouteInfo<dynamic>>[
          LoginRoute(),
        ]);
        _isRedirectingToLogin = false;
      }
      handler.next(err);
      return;
    }

    handler.next(err);
  }
}

/// Logs request / response details in debug builds only.
class LoggingInterceptor extends Interceptor {
  DateTime? _startTime;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _startTime = DateTime.now();
    if (kDebugMode) {
      Log.d('──────────── Request ────────────');
      Log.i('${options.method} ${options.uri}');
      Log.w('Headers: ${options.headers}');
      if (options.data is FormData) {
        final FormData fd = options.data as FormData;
        Log.w('FormData fields: ${fd.fields.map((e) => e.key).join(', ')}');
        Log.w('FormData files : ${fd.files.map((e) => '${e.key}(${e.value.filename})').join(', ')}');
      } else if (options.data != null) {
        Log.w('Body: ${options.data}');
      }
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      final int ms = DateTime.now().difference(_startTime ?? DateTime.now()).inMilliseconds;
      Log.d('──────────── Response ────────────');
      Log.i('${response.statusCode} ${response.requestOptions.uri} (${ms}ms)');
      Log.w('Body: ${response.data}');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      Log.e('──────────── Error ────────────');
      Log.e('${err.type} ${err.requestOptions.uri}');
      Log.e('Status: ${err.response?.statusCode}');
      Log.e('Body  : ${err.response?.data}');
    }
    ViewsToolbox.dismissLoading();
    handler.next(err);
  }
}
