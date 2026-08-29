import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Thin, injectable wrapper around [FlutterSecureStorage] for auth tokens.
///
/// All token I/O should go through this class, not through [LocalData] directly.
/// Inject via `get_it` / `injectable` using [AuthStorage.instance] or DI.
class AuthStorage {
  const AuthStorage(this._storage);

  final FlutterSecureStorage _storage;

  static const String _tokenKey = 'auth_token';

  Future<void> setToken(String token) => _storage.write(key: _tokenKey, value: token);

  Future<String?> getToken() => _storage.read(key: _tokenKey);

  Future<void> deleteToken() => _storage.delete(key: _tokenKey);
}
