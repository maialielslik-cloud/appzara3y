class PaymentModel {
  final String id;
  final String orderId;

  final double amount;

  final String method; // visa | cash | wallet
  final String status; // pending | paid | failed

  final DateTime createdAt;

  PaymentModel({
    required this.id,
    required this.orderId,
    required this.amount,
    required this.method,
    required this.status,
    required this.createdAt,
  });

  // ============================
  //  Convert to Map (Firestore)
  // ============================
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "orderId": orderId,
      "amount": amount,
      "method": method,
      "status": status,
      "createdAt": createdAt.toIso8601String(),
    };
  }

  // ============================
  //  From Map
  // ============================
  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      id: map["id"] ?? "",
      orderId: map["orderId"] ?? "",
      amount: (map["amount"] as num).toDouble(),
      method: map["method"] ?? "unknown",
      status: map["status"] ?? "pending",
      createdAt: DateTime.parse(map["createdAt"]),
    );
  }
}