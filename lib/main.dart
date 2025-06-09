import 'package:device_preview/device_preview.dart';
import 'package:fitstart/views/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/onboarding_screen.dart';

void main() {
  // runApp(const MyApp());
     runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Fitness App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Helvetica', // Example font to match design
      ),
       initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => const SplashScreen()),
        GetPage(name: '/onboarding', page: () => const OnboardingScreen()),
      ],
    );
  }
}
