import 'package:flutter/material.dart';
import 'dart:math';
import 'package:appzara3y/services/payment_service.dart';
import '../models/payment.dart';

class PaymentProvider extends ChangeNotifier {
  // ============================
  //  Payment State
  // ============================
  String _selectedMethod = "visa"; // visa | cash | wallet
  bool _isLoading = false;
  String _status = "idle"; // idle | processing | success | failed

  String get selectedMethod => _selectedMethod;
  bool get isLoading => _isLoading;
  String get status => _status;

  // ============================
  //  Change Payment Method
  // ============================
  void selectMethod(String method) {
    _selectedMethod = method;
    notifyListeners();
  }

  // ============================
  //  Process Payment
  // ============================
  Future<void> processPayment({
    required String orderId,
    required double amount,
  }) async {
    try {
      _isLoading = true;
      _status = "processing";
      notifyListeners();

      // ============================
      //  هنا تقدر تربط Paymob أو Stripe
      // ============================
      await Future.delayed(const Duration(seconds: 2));

      // مثال (مستقبلاً):
      /*
      if (_selectedMethod == "visa") {
        await StripeService.pay(...);
      } else if (_selectedMethod == "wallet") {
        await PaymobService.pay(...);
      }
      */

      // ============================
      //  Save Payment to Firestore
      // ============================
      final payment = PaymentModel(
        id: _generateId(),
        orderId: orderId,
        amount: amount,
        method: _selectedMethod,
        status: "paid",
        createdAt: DateTime.now(),
      );

      await PaymentService.createPayment(payment);

      // ============================
      //  Success
      // ============================
      _status = "success";
    } catch (e) {
      _status = "failed";
    }

    _isLoading = false;
    notifyListeners();
  }

  // ============================
  //  Generate Payment ID
  // ============================
  String _generateId() {
    return "PAY-${Random().nextInt(999999)}";
  }

  // ============================
  //  Reset State (اختياري)
  // ============================
  void reset() {
    _selectedMethod = "visa";
    _isLoading = false;
    _status = "idle";
    notifyListeners();
  }
}