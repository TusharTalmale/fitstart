import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';
import '../viewmodels/onboarding_viewmodel.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingViewModel());
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            // PageView
            PageView.builder(
              controller: controller.pageController,
              onPageChanged: (index) {
                controller.selectedPageIndex.value = index;
              },
              itemCount: controller.onboardingPages.length,
              itemBuilder: (_, index) {
                final item = controller.onboardingPages[index];
                return Stack(
                  children: [
                    // Background Image
                    Positioned.fill(
                      child: Image.asset(item.image!, fit: BoxFit.cover),
                    ),
        
                    // Logo at the top
                    Positioned(
                      top: 9,
                      left: 12,
                      child: Image.asset(
                        'assets/images/kettlebell_logo.png',
                        height: 88,
                        width: 65,
                      ),
                    ),
        
                    // Texts at bottom
                    Positioned(
                      bottom: screenHeight * 0.05,
                      left: 20,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (item.text1 != null)
                            Text(
                              item.text1!,
                              style: _textStyle,
                              textAlign: TextAlign.center,
                            ),
                          if (item.text2 != null)
                            Text(
                              item.text2!,
                              style: _textStyle,
                              textAlign: TextAlign.center,
                            ),
                          if (item.text3 != null)
                            Text(
                              item.text3!,
                              style: _textStyle,
                              textAlign: TextAlign.center,
                            ),
        
                            SizedBox(height: 20,),
                            //  bottom buttons  + sign In
        
                          Obx(() {
                            bool isLast =
                                controller.selectedPageIndex.value ==
                                controller.onboardingPages.length - 1;
                            if (isLast) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 40,
                                    ),
                                    child: ElevatedButton(
                                      onPressed: controller.getStarted,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primaryColor,
                                        minimumSize: const Size(
                                          double.infinity,
                                          50,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        controller
                                                .onboardingPages
                                                .last
                                                .buttonText ??
                                            'Get Started',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Already a user? ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Navigate to sign-in
                                        },
                                        child: const Text(
                                          'Sign in',
                                          style: TextStyle(
                                            color: AppColors.primaryColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            } else {
                              return const SizedBox(
                                height: 20,
                              ); // reserve space
                            }
                          }),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
                  const SizedBox(height: 20),
        
            // Indicators
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    controller.onboardingPages.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width:
                          controller.selectedPageIndex.value == index
                              ? 12
                              : 8,
                      height:
                          controller.selectedPageIndex.value == index
                              ? 12
                              : 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            controller.selectedPageIndex.value == index
                                ? AppColors.primaryColor
                                : Colors.grey,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle get _textStyle => const TextStyle(
    color: Colors.white,
    fontSize: 36,
    fontWeight: FontWeight.bold,
  );
}
