import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/user.dart';
import '../network/dio_client.dart';

class AuthRepository {
  AuthRepository({required DioClient dioClient, required SharedPreferences prefs})
      : _dioClient = dioClient,
        _prefs = prefs;

  final DioClient _dioClient;
  final SharedPreferences _prefs;

  static const _tokenKey = 'auth_token';

  Future<User> login({required String email, required String password}) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    final base = _dioClient.dio.options.baseUrl;
    if (email.isEmpty || !email.contains('@')) {
      throw Exception('invalid_email');
    }
    if (password.length < 6) {
      throw Exception('password_too_short');
    }

    final token = 'mock_token_${DateTime.now().millisecondsSinceEpoch}_${base.hashCode}';
    await _prefs.setString(_tokenKey, token);
    return User(name: email.split('@').first, email: email, token: token);
  }

  Future<void> logout() async {
    await _prefs.remove(_tokenKey);
  }

  String? getToken() => _prefs.getString(_tokenKey);

  bool isLoggedIn() => getToken() != null;
}