import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  Future<bool> login(String email, String password) async {
    // Simulating API call
    await Future.delayed(const Duration(seconds: 2));
    _isAuthenticated = true;
    notifyListeners();
    return true;
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}

# EOF for auth_provider.dart
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _error;

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await Future.delayed(const Duration(seconds: 1));
      _isAuthenticated = true;
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signInAsGuest() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await Future.delayed(const Duration(seconds: 1));
      _isAuthenticated = true;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    _isAuthenticated = false;
    notifyListeners();
  }
}
