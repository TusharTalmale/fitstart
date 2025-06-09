import 'dart:async';
import 'package:get/get.dart';

class SplashViewModel extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _navigateToOnboarding();
  }

  void _navigateToOnboarding() {
    print("Splash Timer started...");
    Timer(const Duration(seconds: 3), () {
      print("Navigating to Onboarding...");
      Get.offNamed('/onboarding');
    });
  }
}
