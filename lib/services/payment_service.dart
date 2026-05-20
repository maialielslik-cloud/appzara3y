import '../models/payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ============================
  //  Create Payment
  // ============================
  static Future<void> createPayment(PaymentModel payment) async {
    await _db.collection("payments").doc(payment.id).set(payment.toMap());
  }

  // ============================
  //  Get All Payments
  // ============================
  static Future<List<PaymentModel>> getAllPayments() async {
    final snapshot = await _db.collection("payments").get();

    return snapshot.docs
        .map((doc) => PaymentModel.fromMap(doc.data()))
        .toList();
  }

  // ============================
  //  Get Payments By Order
  // ============================
  static Future<List<PaymentModel>> getPaymentsByOrder(String orderId) async {
    final snapshot = await _db
        .collection("payments")
        .where("orderId", isEqualTo: orderId)
        .get();

    return snapshot.docs
        .map((doc) => PaymentModel.fromMap(doc.data()))
        .toList();
  }

  // ============================
  //  Realtime Stream (All)
  // ============================
  static Stream<List<PaymentModel>> streamPayments() {
    return _db
        .collection("payments")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => PaymentModel.fromMap(doc.data()))
          .toList();
    });
  }

  // ============================
  //  Realtime Stream (By Order)
  // ============================
  static Stream<List<PaymentModel>> streamPaymentsByOrder(String orderId) {
    return _db
        .collection("payments")
        .where("orderId", isEqualTo: orderId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => PaymentModel.fromMap(doc.data()))
          .toList();
    });
  }

  // ============================
  //  Update Payment Status
  // ============================
  static Future<void> updatePaymentStatus(String paymentId,
      String status) async {
    await _db.collection("payments").doc(paymentId).update({
      "status": status,
    });
  }

  // ============================
  //  Delete Payment
  // ============================
  static Future<void> deletePayment(String paymentId) async {
    await _db.collection("payments").doc(paymentId).delete();
  }
}