import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import 'api_service.dart';

class AuthService {
  AuthService(this._api);

  final ApiService _api;
  static const _tokenKey = 'verdex_token';
  static const _userKey = 'verdex_user';

  String? _token;
  User? _user;

  String? get token => _token;
  User? get user => _user;
  bool get isLoggedIn => _token != null && _user != null;

  Future<void> loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString(_tokenKey);
    final userJson = prefs.getString(_userKey);
    if (userJson != null) {
      _user = User.fromJson(jsonDecode(userJson) as Map<String, dynamic>);
    }
    _api.setToken(_token);
  }

  Future<User> login({
    required String email,
    required String password,
  }) async {
    final data = await _api.login(email: email, password: password);
    await _persistSession(
      data['token'] as String,
      User.fromJson(data['user'] as Map<String, dynamic>),
    );
    return _user!;
  }

  Future<User> register({
    required String fullName,
    required String email,
    required String password,
    required UserRole role,
  }) async {
    final data = await _api.register(
      fullName: fullName,
      email: email,
      password: password,
      role: role,
    );
    await _persistSession(
      data['token'] as String,
      User.fromJson(data['user'] as Map<String, dynamic>),
    );
    return _user!;
  }

  Future<void> logout() async {
    _token = null;
    _user = null;
    _api.setToken(null);
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
  }

  Future<void> _persistSession(String token, User user) async {
    _token = token;
    _user = user;
    _api.setToken(token);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
  }
}
