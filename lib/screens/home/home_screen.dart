import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 1. استيراد البروفايدر
import '../../core/constants.dart';

import '../disease_detection/disease_detection_screen.dart';
import '../../providers/auth_provider.dart'; // 2. تأكدي من مسار البروفايدر
import '../../providers/navigation_provider.dart';
import 'package:animate_do/animate_do.dart';

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // نداء البروفايدر
    final authProvider = context.watch<AuthProvider>();
    final navProvider = Provider.of<NavigationProvider>(context, listen: false);
    final userName = authProvider.user?.name ?? "مزارعنا العزيز";

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            FadeInDown(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('مرحباً بك،', style: TextStyle(fontSize: 18)),
                      Text(
                        '$userName 🌱',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      navProvider.setSelectedIndex(4);
                    },
                    child: const CircleAvatar(
                      radius: 28,
                      backgroundColor: AppColors.primary,
                      child: Icon(Icons.person, color: Colors.white, size: 32),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // كارت الجو
            FadeInLeft(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryLight],
                  ),
                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('حالة الجو اليوم', style: TextStyle(color: Colors.white, fontSize: 18)),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.wb_sunny, color: Colors.amber, size: 40),
                        SizedBox(width: 16),
                        Text('28° م', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text('الأدوات السريعة', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            // هنا المربعات اللي كان فيها المشكلة
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildQuickCard(context, 'دليل المحاصيل', Icons.agriculture_rounded, AppColors.primary, () {
                  navProvider.setSelectedIndex(1);
                }),
                _buildQuickCard(context, 'تشخيص الأمراض', Icons.camera_alt_rounded, Colors.orange, () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DiseaseDetectionScreen()));
                }),
                _buildQuickCard(context, 'المساعد الذكي', Icons.chat_bubble_rounded, Colors.blue, () {
                  navProvider.setSelectedIndex(2);
                }),
                _buildQuickCard(context, 'المتجر الزراعي', Icons.shopping_cart_rounded, Colors.purple, () {
                  navProvider.setSelectedIndex(3);
                }),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

  Widget _buildQuickCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return FadeInUp(
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: color.withAlpha(38), shape: BoxShape.circle),
                child: Icon(icon, color: color, size: 30),
              ),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}