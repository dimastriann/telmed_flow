import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _currentAccount = 'John Doe';
  final List<String> _accounts = ['John Doe', 'Jane Doe', 'Jimmy Doe'];

  bool get isLoggedIn => _isLoggedIn;
  String get currentAccount => _currentAccount;
  List<String> get accounts => _accounts;

  void login(String email, String password) {
    // Mock login logic
    if (email.isNotEmpty && password.isNotEmpty) {
      _isLoggedIn = true;
      notifyListeners();
    }
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }

  void switchAccount(String accountName) {
    if (_accounts.contains(accountName)) {
      _currentAccount = accountName;
      notifyListeners();
    }
  }

  void addAccount(String accountName) {
    if (!_accounts.contains(accountName)) {
      _accounts.add(accountName);
      notifyListeners();
    }
  }
}
