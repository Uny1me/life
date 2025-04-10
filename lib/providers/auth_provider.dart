import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user_data.dart';

class AuthProvider with ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  bool _isAuthenticated = false;
  UserData? _userData;

  bool get isAuthenticated => _isAuthenticated;
  UserData? get userData => _userData;

  Future<void> login() async {
    // TODO: Implement actual login logic
    await _storage.write(key: 'auth_token', value: 'dummy_token');
    _isAuthenticated = true;
    notifyListeners();
  }

  Future<void> signup(UserData userData) async {
    // TODO: Implement actual signup logic with backend
    _userData = userData;
    await _storage.write(key: 'user_data', value: userData.toJson().toString());
    await login();
  }

  Future<void> logout() async {
    await _storage.deleteAll();
    _isAuthenticated = false;
    _userData = null;
    notifyListeners();
  }

  Future<void> checkAuthStatus() async {
    final token = await _storage.read(key: 'auth_token');
    _isAuthenticated = token != null;
    if (_isAuthenticated) {
      final userDataStr = await _storage.read(key: 'user_data');
      if (userDataStr != null) {
        // TODO: Implement proper JSON parsing
        // _userData = UserData.fromJson(jsonDecode(userDataStr));
      }
    }
    notifyListeners();
  }
}
