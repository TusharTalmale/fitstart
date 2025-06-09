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
              onPageChanged: controller.onPageChanged,
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

                    // Content Section (Text and Buttons/Login Form)
                     Positioned(
                      bottom: screenHeight * 0.05,
                      left: 20,
                      right: 20,
                      child:      _buildContentColumn(controller, item) ),
                  ],
                );
              },
            ),

            // Indicators
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    controller.onboardingPages.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width:
                          controller.selectedPageIndex.value == index ? 12 : 8,
                      height:
                          controller.selectedPageIndex.value == index ? 12 : 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            controller.selectedPageIndex.value == index
                                ? AppColors.primaryColor
                                : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget _buildContentColumn(OnboardingViewModel controller, item) {
  return Obx(() {
    final hideText = controller.showLoginUI.value && 
                     controller.isLastPage;
    
    return  Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                           if (!hideText) ...[
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

                          const SizedBox(height: 20),
                         
                        ],
                         _buildBottomSection(controller),]
                      )
           ;    });     
              
}
  // This widget decides what to show on the last page
  Widget _buildBottomSection(OnboardingViewModel controller) {
    return Obx(() {
      bool isLastPage =
          controller.selectedPageIndex.value ==
          controller.onboardingPages.length - 1;
      if (isLastPage) {
        // On the last page, we check another state: showLoginUI
        return Obx(() {
          if (controller.showLoginUI.value) {
            return _buildLoginForm(controller);
          } else {
            return _buildGetStartedButton(controller);
          }
        });
      } else {
        return const SizedBox(height: 10);
      }
    });
  }

  // The "Get Started" button widget
  Widget _buildGetStartedButton(OnboardingViewModel controller) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
            onPressed: controller.onGetStartedClicked,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              controller.onboardingPages.last.buttonText ?? 'Get Started',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        _signIntext(),
      ],
    );
  }
Widget _buildLoginForm(OnboardingViewModel controller) {
  const fieldHeight = 55.0;

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
        "LET’S YOU IN",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
      const SizedBox(height: 20),
        // Mobile Number Field with Arrow Button
        Container(
          height: fieldHeight,
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller.mobileController,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: 'Mobile No.',
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward, color: Colors.black),
                  onPressed: controller.getOTP,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // OTP Field
        Container(
          height: fieldHeight,
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(40),
          ),
          child: Center(
            child: TextField(
              controller: controller.otpController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: 'OTP',
                hintStyle: TextStyle(color: Colors.white),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),

        // Resend OTP Text
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: controller.getOTP,
            child: const Text(
              'RESEND OTP',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        _signIntext(),
      ],
      
    ),
  );
}


  // Common text style for the main text
  TextStyle get _textStyle => const TextStyle(
    color: Colors.white,
    fontSize: 36,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  Widget _signIntext() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already a user? ',
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
        TextButton(
          onPressed: () {
            // Navigate to sign-in
          },

          child: const Text(
            'Sign in',
            style: TextStyle(color: AppColors.primaryColor, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
