import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart'; // 1. لازم السطر ده
import 'core/theme.dart';
import 'screens/splash/splash_screen.dart';
import 'providers/auth_provider.dart'; // 2. تأكدي من مسار ملف الـ AuthProvider عندك
import 'providers/navigation_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Try to initialize Firebase
    await Firebase.initializeApp();
  } catch (e) {
    // If Firebase fails (e.g. missing config files), log the error
    // and let the app proceed if possible (with simulated state)
    print('Firebase initialization failed: $e');
  }

  runApp(
    // 3. تغليف الأبلكيشن بالـ MultiProvider
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: const AgriSmartApp(),
    ),
  );
}

class AgriSmartApp extends StatelessWidget {
  const AgriSmartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agri Smart Guide Pro',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      locale: const Locale('ar', 'EG'),
      supportedLocales: const [Locale('ar', 'EG')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const SplashScreen(),
    );
  }
}
