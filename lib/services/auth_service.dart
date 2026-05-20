import 'package:firebase_auth/firebase_auth.dart'; // السطر ده كان ناقص
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class AuthService {
  // Use getters to handle potential initialization errors gracefully
  FirebaseAuth get _auth {
    try {
      return FirebaseAuth.instance;
    } catch (e) {
      throw Exception('Firebase Auth is not initialized. Check your configuration.');
    }
  }

  FirebaseFirestore get _db {
    try {
      return FirebaseFirestore.instance;
    } catch (e) {
      throw Exception('Firestore is not initialized. Check your configuration.');
    }
  }

  // =========================
  //  Register
  // =========================
  Future<String?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // 1. Create user in Firebase Auth
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = result.user!;
      final userId = user.uid;

      // 2. Create UserModel
      final userModel = UserModel(
        uid: userId,
        name: name,
        email: email,
        password: password,
      );

      // 3. Save to Firestore
      await _db.collection('users').doc(userId).set(userModel.toMap());

      return null; // Success
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e);
    } catch (e) {
      return "اسم المستخدم أو البريد الإلكتروني غير متاح (أو مشكلة في الاتصال): ${e.toString()}";
    }
  }

  // =========================
  //  Login
  // =========================
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e);
    } catch (e) {
      return "فشل تسجيل الدخول. تأكد من ثبات الاتصال أو إعدادات الخدمة.";
    }
  }

  // =========================
  //  Get Current User Data
  // =========================
  Future<UserModel?> getUserData(String userId) async {
    try {
      final doc = await _db.collection('users').doc(userId).get();
      if (!doc.exists || doc.data() == null) return null;

      return UserModel.fromMap(doc.data()!, doc.id);
    } catch (e) {
      return null;
    }
  }

  // =========================
  //  Logout
  // =========================
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      // Ignore logout errors
    }
  }

  // =========================
  //  Error Handling
  // =========================
  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return "هذا البريد الإلكتروني مسجل بالفعل.";
      case 'invalid-email':
        return "صيغة البريد الإلكتروني غير صحيحة.";
      case 'weak-password':
        return "كلمة المرور ضعيفة جداً.";
      case 'user-not-found':
        return "لا يوجد حساب بهذا البريد.";
      case 'wrong-password':
        return "كلمة المرور غير صحيحة.";
      default:
        return e.message ?? "حدث خطأ في المصادقة.";
    }
  }
}