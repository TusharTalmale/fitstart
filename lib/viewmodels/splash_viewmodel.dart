import 'dart:async';
import 'package:get/get.dart';

class SplashViewModel extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _navigateToOnboarding();
  }

  void _navigateToOnboarding() {
    Timer(const Duration(seconds: 3), () {
      // Get.offNamed('/onboarding');
      Get.offAllNamed('/profile-setup');
      // Get.offAllNamed('/check');
    });
  }
}
