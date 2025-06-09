import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';
import '../viewmodels/splash_viewmodel.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
  final screenHeight = MediaQuery.of(context).size.height;

    // Register the viewmodel
    Get.put(SplashViewModel());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 6, height: screenHeight * 0.35, color: AppColors.primaryColor),
              const SizedBox(height: 24),
              Image.asset('assets/images/kettlebell_logo.png', height: screenHeight*0.16, width: 110,
          ),
              const SizedBox(height: 24),
              Container(width: 6, height: screenHeight * 0.35, color: AppColors.primaryColor),
            ],
          ),
        ),
      ),
    );
  }
}
