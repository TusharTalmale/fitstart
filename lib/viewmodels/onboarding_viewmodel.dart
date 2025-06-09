import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/onboarding_info.dart';

class OnboardingViewModel extends GetxController {
  var selectedPageIndex = 0.obs;
  final pageController = PageController();

  void getStarted() {
    Get.offNamed('/home');
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  final onboardingPages = [
    OnboardingInfo(
      image: 'assets/images/startpage/page1.png',
      text1: 'ONE STOP',
      text2: 'SOLUTION FOR ALL',
      text3: 'FITNESS NEEDS',
    ),
    OnboardingInfo(
      image: 'assets/images/startpage/page2.png',
      text1: 'SINGLE CARD FOR',
      text2: 'ALL YOUR FITNESS',
      text3: 'NEEDS',
    ),
    OnboardingInfo(
      image: 'assets/images/startpage/page3.png',
      text1: 'START YOUR',
      text2: 'JOURNEY TODAY',
      buttonText: 'Get Started',
    ),
  ];
}
