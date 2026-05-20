import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 1. استيراد البروفايدر
import 'package:animate_do/animate_do.dart';
import '../../core/constants.dart';
import '../../widgets/custom_text_field.dart';
import '../main_screen.dart';
import '../../providers/auth_provider.dart'; // 2. تأكدي من مسار الملف عندك

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // الدالة المعدلة لعمل تسجيل حقيقي
  void _register() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    // التحقق من إدخال البيانات
    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showErrorSnackBar('الرجاء إدخال جميع الحقول.');
      return;
    }

    if (password != confirmPassword) {
      _showErrorSnackBar('كلمتا المرور غير متطابقتين.');
      return;
    }

    // الوصول للـ AuthProvider
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // البدء في عملية التسجيل في فايربيز
    bool success = await authProvider.register(
      name: name,
      email: email,
      password: password,
    );

    if (mounted) {
      if (success) {
        // إذا نجح التسجيل، ننتقل لصفحة الهوم
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
              (route) => false,
        );
      } else {
        // إذا فشل، نظهر رسالة الخطأ القادمة من فايربيز
        _showErrorSnackBar(authProvider.error ?? 'حدث خطأ أثناء التسجيل');
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
    // نراقب حالة الـ Loading من البروفايدر لتحديث الزرار
    final authLoading = context.watch<AuthProvider>().isLoading;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.padding * 1.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInDown(
                child: Text(
                  'إنشاء حساب جديد',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              FadeInDown(
                delay: const Duration(milliseconds: 200),
                child: Text(
                  'انضم إلينا لتبدأ رحلتك الزراعية الذكية',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 40),
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: CustomTextField(
                  label: 'الاسم الكامل',
                  hint: ' ',
                  icon: Icons.person_outline,
                  controller: _nameController,
                ),
              ),
              const SizedBox(height: 20),
              FadeInUp(
                delay: const Duration(milliseconds: 400),
                child: CustomTextField(
                  label: 'البريد الإلكتروني',
                  hint: 'example@mail.com',
                  icon: Icons.email_outlined,
                  controller: _emailController,
                ),
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
              FadeInUp(
                delay: const Duration(milliseconds: 600),
                child: CustomTextField(
                  label: 'تأكيد كلمة المرور',
                  hint: '********',
                  icon: Icons.lock_reset_outlined,
                  isPassword: true,
                  controller: _confirmPasswordController,
                ),
              ),
              const SizedBox(height: 48),
              FadeInUp(
                delay: const Duration(milliseconds: 700),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    // الزرار يتعطل أثناء التحميل
                    onPressed: authLoading ? null : _register,
                    child: authLoading
                        ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                        : const Text('إنشاء الحساب'),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              FadeInUp(
                delay: const Duration(milliseconds: 800),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('لديك حساب بالفعل؟'),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('سجل دخولك'),
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