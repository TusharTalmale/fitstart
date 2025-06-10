

import 'package:fitstart/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CongratulationsScreen extends StatelessWidget {
  const CongratulationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, 
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0), 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                
                Image.asset(
                  'assets/images/startpage/congratulation.png',
                  height: 85, 
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 25),
                const Text(
                  "Congratulation",
                  textAlign: TextAlign.center, // Center text horizontally
                  style: TextStyle(
                    color: AppColors.primaryColor, 
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0), 
                  child: Text(
                    "Your Profile \n Has Been Created!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                     
                      color: AppColors.primaryColor.withOpacity(0.8),
                      fontSize: 27, 
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
