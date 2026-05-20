import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 1. استيراد البروفايدر
import '../../core/constants.dart';
import '../auth/login_screen.dart';
import '../../providers/auth_provider.dart'; // 2. تأكدي من المسار
import 'package:animate_do/animate_do.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 3. نداء البروفايدر لقراءة البيانات
    final authProvider = context.watch<AuthProvider>();
    final user = authProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('الملف الشخصي'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.padding),
        child: Column(
          children: [
            const SizedBox(height: 20),
            FadeInDown(
              child: Center(
                child: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 64,
                      backgroundColor: AppColors.primary,
                      backgroundImage: NetworkImage('https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=200&auto=format&fit=crop'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: AppColors.secondary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.edit, color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            FadeInDown(
              delay: const Duration(milliseconds: 200),
              child: Text(
                // 4. عرض الاسم الحقيقي
                user?.name ?? 'مزارعنا العزيز',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 4),
            FadeInDown(
              delay: const Duration(milliseconds: 300),
              // 5. عرض الإيميل الحقيقي
              child: Text(
                user?.email ?? 'لا يوجد بريد إلكتروني',
                style: const TextStyle(color: AppColors.textSecondary),
              ),
            ),
            const SizedBox(height: 40),
            _buildProfileItem(context, 'معلومات الحساب', Icons.person_outline),
            _buildProfileItem(context, 'مزارعي المفضلة', Icons.favorite_border),
            _buildProfileItem(context, 'الإشعارات', Icons.notifications_none_outlined),
            _buildProfileItem(context, 'الإعدادات', Icons.settings_outlined),
            _buildProfileItem(context, 'عن التطبيق', Icons.info_outline),
            const SizedBox(height: 32),
            FadeInUp(
              child: TextButton.icon(
                onPressed: () async {
                  // 6. نداء دالة تسجيل الخروج الحقيقية
                  await authProvider.logout();

                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                          (route) => false,
                    );
                  }
                },
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text('تسجيل الخروج', style: TextStyle(color: Colors.red, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(BuildContext context, String title, IconData icon) {
    return FadeInUp(
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: ListTile(
          leading: Icon(icon, color: AppColors.primary),
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
      ),
    );
  }
}