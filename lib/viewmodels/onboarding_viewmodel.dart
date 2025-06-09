import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/onboarding_info.dart';

class OnboardingViewModel extends GetxController {
  var selectedPageIndex = 0.obs;
  var showLoginUI = false.obs;
  bool get isLastPage => selectedPageIndex.value == onboardingPages.length - 1;

  final pageController = PageController();
  final mobileController = TextEditingController();
  final otpController = TextEditingController();

  void onGetStartedClicked() {
    showLoginUI.value = true;
  }

  void getOTP() {
    final mobileNumber = mobileController.text;
    if (mobileNumber.isNotEmpty) {
      print('Getting OTP for: $mobileNumber');
      // Example: Get.snackbar("Success", "OTP sent to $mobileNumber");
    } else {
      // Example: Get.snackbar("Error", "Please enter a mobile number");
    }
  }

  void onPageChanged(int index) {
    selectedPageIndex.value = index;
    if (index != onboardingPages.length - 1) {
      showLoginUI.value = false;
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    mobileController.dispose();
    otpController.dispose();
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
