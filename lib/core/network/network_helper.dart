import 'package:dio/dio.dart';
import 'package:flexiJobs/core/network/api/network_apis_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'exception/exception_handle.dart';
import 'interceptors.dart';

@injectable
class NetworkHelper {
  NetworkHelper(this.dio) {
    dio.interceptors
      ..clear()
      ..add(AuthInterceptor())
      ..addAll(kDebugMode ? <Interceptor>[LoggingInterceptor()] : <Interceptor>[]);
  }

  final Dio dio;

  Future<({dynamic response, bool success})> delete({
    required String path,
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final Response<dynamic> response = await dio.delete(
        path,
        data: data,
        options: Options(
          headers: headers,
          receiveTimeout: const Duration(seconds: 60),
          sendTimeout: const Duration(seconds: 60),
        ),
      );
      if (_isSuccess(response.statusCode)) {
        return (response: response.data, success: true);
      }
      return (response: _extractMessage(response.data), success: false);
    } on DioException catch (e) {
      return (response: _handleDioError(e), success: false);
    }
  }

  Future<({dynamic response, bool success})> get({
    required String path,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final Response<dynamic> response = await dio.get(
        path,
        queryParameters: queryParams
          ?..removeWhere((String key, dynamic value) => value == null),
        options: Options(
          headers: headers,
          receiveTimeout: const Duration(seconds: 60),
          sendTimeout: const Duration(seconds: 60),
        ),
      );

      if (_isSuccess(response.statusCode)) {
        return (response: response.data, success: true);
      }
      return (response: _extractMessage(response.data), success: false);
    } on DioException catch (e) {
      return (response: _handleDioError(e), success: false);
    }
  }

  Future<({dynamic response, bool success})> post({
    required String path,
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      _stripNulls(data);
      queryParams?.removeWhere((String key, dynamic value) => value == null);

      final Response<dynamic> response = await dio.post(
        path,
        data: data,
        queryParameters: queryParams,
        options: Options(
          headers: headers,
          receiveTimeout: const Duration(seconds: 60),
          sendTimeout: const Duration(seconds: 60),
        ),
      );

      if (_isSuccess(response.statusCode)) {
        // Special-case: 201 on applyOnJob triggers intro-video flow
        if (response.statusCode == 201 && path == ApiConstants.applyOnJob) {
          return (response: 'intro', success: true);
        }
        return (response: response.data, success: true);
      }
      return (response: _extractMessage(response.data), success: false);
    } on DioException catch (e) {
      return (response: _handleDioError(e), success: false);
    }
  }

  Future<({dynamic response, bool success})> put({
    required String path,
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      _stripNulls(data);
      final Response<dynamic> response = await dio.put(
        path,
        data: data,
        options: Options(
          headers: headers,
          receiveTimeout: const Duration(seconds: 60),
          sendTimeout: const Duration(seconds: 60),
        ),
      );
      if (_isSuccess(response.statusCode)) {
        return (response: response.data, success: true);
      }
      return (response: _extractMessage(response.data), success: false);
    } on DioException catch (e) {
      return (response: _handleDioError(e), success: false);
    }
  }

  // ── Helpers ─────────────────────────────────────────────────────────────────

  static bool _isSuccess(int? code) =>
      code != null && code >= 200 && code < 300;

  static dynamic _extractMessage(dynamic body) {
    return _findMessage(body) ?? 'Unexpected error';
  }

  static dynamic _handleDioError(DioException e) {
    if (e.response?.data != null && e.response?.statusCode != 500) {
      final String? message = _findMessage(e.response!.data);
      if (message != null) return message;
    }
    final NetError netError = ExceptionHandle.handleException(e);
    return netError.msg;
  }

  static String? _findMessage(dynamic body) {
    if (body is String && body.trim().isNotEmpty) return body;
    if (body is List<dynamic> && body.isNotEmpty) {
      return _findMessage(body.first);
    }
    if (body is Map<String, dynamic>) {
      for (final String key in <String>['message', 'error', 'Error']) {
        final String? message = _findMessage(body[key]);
        if (message != null) return message;
      }
      final String? dataMessage = _findMessage(body['data']);
      if (dataMessage != null) return dataMessage;
      final String? errorsMessage = _findMessage(body['errors']);
      if (errorsMessage != null) return errorsMessage;
    }
    return null;
  }

  static void _stripNulls(dynamic data) {
    if (data is Map<String, dynamic>) {
      data.removeWhere((String key, dynamic value) => value == null);
    } else if (data is List<Map<String, dynamic>>) {
      for (final Map<String, dynamic> item in data) {
        item.removeWhere((String key, dynamic value) => value == null);
      }
    }
  }
}
