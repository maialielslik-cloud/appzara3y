import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 1. استيراد البروفايدر
import 'package:animate_do/animate_do.dart';
import '../../core/constants.dart';
import '../../widgets/custom_text_field.dart';
import '../main_screen.dart';
import 'register_screen.dart';
import '../../providers/auth_provider.dart'; // 2. تأكدي من مسار ملف البروفايدر

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // الدالة المعدلة لعمل تسجيل دخول حقيقي
  void _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showErrorSnackBar('الرجاء إدخال البريد الإلكتروني وكلمة المرور.');
      return;
    }

    // الوصول للـ AuthProvider
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // نداء دالة تسجيل الدخول من البروفايدر
    bool success = await authProvider.login(
      email: email,
      password: password,
    );

    if (mounted) {
      if (success) {
        // لو نجح، انقل المستخدم للهوم وامسح كل اللي فات
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
              (route) => false,
        );
      } else {
        // لو فشل، اظهر رسالة الخطأ (باسورد غلط مثلاً)
        _showErrorSnackBar(authProvider.error ?? 'فشل تسجيل الدخول');
      }
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // مراقبة حالة التحميل من البروفايدر
    final authLoading = context.watch<AuthProvider>().isLoading;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.padding * 1.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              FadeInDown(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(25),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.eco_rounded,
                      size: 60,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              FadeInDown(
                delay: const Duration(milliseconds: 200),
                child: Text(
                  'تسجيل الدخول',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              FadeInDown(
                delay: const Duration(milliseconds: 300),
                child: Text(
                  'أهلاً بك مجدداً في مرشدك الزراعي',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 48),
              FadeInUp(
                delay: const Duration(milliseconds: 400),
                child: CustomTextField(
                  label: 'البريد الإلكتروني',
                  hint: 'example@mail.com',
                  icon: Icons.email_outlined,
                  controller: _emailController,
                ),
              ),
              const SizedBox(height: 24),
              FadeInUp(
                delay: const Duration(milliseconds: 500),
                child: CustomTextField(
                  label: 'كلمة المرور',
                  hint: '********',
                  icon: Icons.lock_outline,
                  isPassword: true,
                  controller: _passwordController,
                ),
              ),
              const SizedBox(height: 12),
              FadeInUp(
                delay: const Duration(milliseconds: 600),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      // ممكن تبرمجي استعادة كلمة المرور هنا لاحقاً
                    },
                    child: const Text('نسيت كلمة المرور؟'),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              FadeInUp(
                delay: const Duration(milliseconds: 700),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    // الزرار يتعطل أثناء التحميل
                    onPressed: authLoading ? null : _login,
                    child: authLoading
                        ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                        : const Text('تسجيل الدخول'),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              FadeInUp(
                delay: const Duration(milliseconds: 800),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('ليس لديك حساب؟'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterScreen()),
                        );
                      },
                      child: const Text('أنشئ حساباً جديداً'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}