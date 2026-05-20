import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 1. استيراد البروفايدر
import 'package:cloud_firestore/cloud_firestore.dart'; // 2. استيراد الفايرستور
import '../../core/constants.dart';
import '../../models/product.dart';
import '../../providers/auth_provider.dart'; // 3. مسار البروفايدر
import 'package:animate_do/animate_do.dart';

class PaymentScreen extends StatefulWidget {
  final Product product;
  const PaymentScreen({super.key, required this.product});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedMethod = 'vodafone';
  bool _isProcessing = false; // لحالة التحميل أثناء الدفع

  // دالة إرسال الطلب للفايربيز
  Future<void> _processPayment() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    setState(() => _isProcessing = true);

    try {
      // 1. إنشاء طلب جديد في الفايرستور
      await FirebaseFirestore.instance.collection('orders').add({
        'userId': authProvider.userId, // معرف المستخدم
        'userName': authProvider.user?.name ?? "مستخدم مجهول",
        'productName': widget.product.name, // جربي name بدل title
        'price': widget.product.price,
        'paymentMethod': _selectedMethod,
        'status': 'pending', // حالة الطلب (قيد الانتظار)
        'createdAt': FieldValue.serverTimestamp(), // وقت الطلب من السيرفر
      });

      if (mounted) {
        _showSuccessDialog(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ أثناء إتمام الطلب: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إتمام الدفع'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'اختر طريقة الدفع',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildPaymentOption('vodafone', 'فودافون كاش', Icons.phone_android, Colors.red),
            const SizedBox(height: 16),
            _buildPaymentOption('card', 'بطاقة ائتمان', Icons.credit_card, Colors.blue),
            const SizedBox(height: 16),
            _buildPaymentOption('cash', 'الدفع عند الاستلام', Icons.money_outlined, Colors.green),
            const Spacer(),
            FadeInUp(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.greyLight.withAlpha(76),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('إجمالي المبلغ:', style: TextStyle(fontSize: 18)),
                        Text(
                          '${widget.product.price} ج.م',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      // تعطيل الزرار أثناء معالجة الطلب
                      onPressed: _isProcessing ? null : _processPayment,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        minimumSize: const Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isProcessing
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                        'تأكيد الدفع',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // باقي الدوال (buildPaymentOption و showSuccessDialog) كما هي في كودك الأصلي
  Widget _buildPaymentOption(String value, String title, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(
          color: _selectedMethod == value ? AppColors.primary : AppColors.greyLight,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: RadioListTile<String>(
        value: value,
        // ignore: deprecated_member_use
        groupValue: _selectedMethod,
        // ignore: deprecated_member_use
        onChanged: (val) {
          if (val != null) {
            setState(() => _selectedMethod = val);
          }
        },
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        secondary: Icon(icon, color: color, size: 32),
        activeColor: AppColors.primary,
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // لا يغلق إلا بالضغط على الزرار
      builder: (context) => AlertDialog(
        title: const Text('تم الطلب بنجاح'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: AppColors.primary, size: 80),
            SizedBox(height: 16),
            Text('سيتم التواصل معك لتأكيد الطلب وشحن المنتج في أقرب وقت.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Text('العودة للرئيسية'),
          ),
        ],
      ),
    );
  }
}