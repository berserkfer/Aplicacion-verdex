import 'package:flutter/foundation.dart';

import '../models/user.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(this._auth, this.api);

  final AuthService _auth;
  final ApiService api;

  bool _loading = true;
  String? _error;

  bool get loading => _loading;
  String? get error => _error;
  bool get isLoggedIn => _auth.isLoggedIn;
  User? get user => _auth.user;

  Future<void> bootstrap() async {
    _loading = true;
    notifyListeners();
    await _auth.loadSession();
    _loading = false;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    return _run(() => _auth.login(email: email, password: password));
  }

  Future<bool> register({
    required String fullName,
    required String email,
    required String password,
    required UserRole role,
  }) async {
    return _run(
      () => _auth.register(
        fullName: fullName,
        email: email,
        password: password,
        role: role,
      ),
    );
  }

  Future<void> logout() async {
    await _auth.logout();
    _error = null;
    notifyListeners();
  }

  Future<bool> _run(Future<User> Function() action) async {
    _error = null;
    _loading = true;
    notifyListeners();
    try {
      await action();
      _loading = false;
      notifyListeners();
      return true;
    } on ApiException catch (e) {
      _error = e.message;
    } catch (e) {
      _error = 'No se pudo completar la operación';
    }
    _loading = false;
    notifyListeners();
    return false;
  }
}
