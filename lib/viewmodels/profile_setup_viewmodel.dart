import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io'; // For File type if you use image_picker

class ProfileSetupViewModel extends GetxController {
  final int totalPages = 7;
  var currentPage = 0.obs;
  final pageController = PageController();

  // Page 1: Profile Info
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final otpController = TextEditingController(); // Assuming OTP from previous screen might be used here
  var termsAccepted = false.obs;

  // Page 2: Gender
  var selectedGender = ''.obs; // "Male", "Female"

  // Page 3: Age
  var selectedAge = 36.obs;

  // Page 4: Weight
  var selectedWeight = 65.obs;
  final weightScrollController = FixedExtentScrollController(initialItem: 2); // Assuming 63, 64, [65], 66, ...

  // Page 5: Height
  var selectedHeight = 175.obs;

  // Page 6: Activity Level
  var activityLevel = 'Intermediate'.obs;

  // Page 7: Fitness Goals
  var fitnessGoals = <String>['Sports'].obs;

  void nextPage() {
    if (currentPage.value < totalPages - 1) {
      currentPage.value++;
      pageController.animateToPage(
        currentPage.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
      pageController.animateToPage(
        currentPage.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void toggleFitnessGoal(String goal) {
    if (fitnessGoals.contains(goal)) {
      fitnessGoals.remove(goal);
    } else {
      fitnessGoals.add(goal);
    }
  }

  void submitProfile() {
    print("---SUBMITTING PROFILE---");
    print("Name: ${firstNameController.text} ${lastNameController.text}");
    print("Email: ${emailController.text}");
    print("Gender: ${selectedGender.value}");
    print("Age: ${selectedAge.value}");
    print("Weight: ${selectedWeight.value} kg");
    print("Height: ${selectedHeight.value} cm");
    print("Activity Level: ${activityLevel.value}");
    print("Fitness Goals: ${fitnessGoals.toList()}");
    print("------------------------");

    Get.offAllNamed('/congratulations'); // Navigate to the main app screen after submission
  }


  @override
  void onClose() {
    pageController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    otpController.dispose();
    weightScrollController.dispose();
    super.onClose();
  }
}