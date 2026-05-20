import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../auth/login_screen.dart';
import 'package:animate_do/animate_do.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _data = [
    OnboardingData(
      title: 'إرشاد المحاصيل',
      description: 'احصل على أفضل النصائح لزراعة محاصيلك في الوقت المناسب وبأفضل الطرق.',
      icon: Icons.agriculture_rounded,
    ),
    OnboardingData(
      title: 'تشخيص الأمراض',
      description: 'صور نباتك واحصل على تشخيص فوري للأمراض مع خطة العلاج المناسبة.',
      icon: Icons.camera_alt_rounded,
    ),
    OnboardingData(
      title: 'المساعد الذكي',
      description: 'تحدث مع خبيرنا الذكي للحصول على إجابات فورية لكل استفساراتك الزراعية.',
      icon: Icons.chat_bubble_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _data.length,
                itemBuilder: (context, index) {
                  return OnboardingPage(data: _data[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppConstants.padding * 2),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _data.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: _currentPage == index ? 24 : 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? AppColors.primary
                              : AppColors.greyLight,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  FadeInUp(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentPage < _data.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        }
                      },
                      child: Text(_currentPage == _data.length - 1
                          ? 'ابدأ الآن'
                          : 'التالي'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final IconData icon;

  OnboardingData({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;

  const OnboardingPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.padding * 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ZoomIn(
            child: Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                data.icon,
                size: 150,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 48),
          FadeInDown(
            child: Text(
              data.title,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: AppColors.primary,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          FadeInUp(
            child: Text(
              data.description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
