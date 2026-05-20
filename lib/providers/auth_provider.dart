import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String? _error;
  bool _isLoggedIn = false;
  String? _userId;
  UserModel? _user;

  // Getters
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _isLoggedIn;
  String get userId => _userId ?? "";
  UserModel? get user => _user;

  // =========================
  //  Register
  // =========================
  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _clearError();

    final result = await _authService.register(
      name: name,
      email: email,
      password: password,
    );

    if (result != null) {
      _setError(result);
      _setLoading(false);
      return false;
    }

    _setLoading(false);
    return true;
  }

  // =========================
  //  Login
  // =========================
  Future<bool> login({required String email, required String password}) async {
    _setLoading(true);
    _clearError();

    try {
      final result = await _authService.login(
        email: email,
        password: password,
      );

      if (result != null) {
        _setError(result);
        _setLoading(false);
        return false;
      }

      final firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser == null) {
        _setError("فشل في استرجاع بيانات المستخدم.");
        _setLoading(false);
        return false;
      }

      _userId = firebaseUser.uid;

      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_userId)
          .get();

      if (doc.exists && doc.data() != null) {
        final data = doc.data() as Map<String, dynamic>;
        _user = UserModel.fromMap(data, _userId!);
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userId', _userId!);

      _isLoggedIn = true;
      _setLoading(false);
      notifyListeners();
      return true;

    } catch (e) {
      _setError("حدث خطأ غير متوقع: $e");
      _setLoading(false);
      return false;
    }
  }

  // =========================
  //  Check Login Status (Auto Login)
  // =========================
  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _userId = prefs.getString('userId');

    if (_isLoggedIn && _userId != null) {
      try {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(_userId)
            .get();

        if (doc.exists && doc.data() != null) {
          final data = doc.data() as Map<String, dynamic>;
          _user = UserModel.fromMap(data, _userId!);
        }
      } catch (e) {
        _error = "فشل في تحميل بيانات المستخدم تلقائياً";
      }
    }
    notifyListeners();
  }

  // =========================
  //  Logout
  // =========================
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    _isLoggedIn = false;
    _userId = null;
    _user = null;

    notifyListeners();
  }

  // =========================
  //  Helpers
  // =========================
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String errorMsg) {
    _error = errorMsg;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
    notifyListeners();
  }
} // القوس ده هو قفلة الكلاس الوحيدة والأخيرة