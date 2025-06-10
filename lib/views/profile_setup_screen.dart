import 'package:fitstart/utils/horizontal_number_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';
import '../viewmodels/profile_setup_viewmodel.dart';

class ProfileSetupScreen extends StatelessWidget {
  const ProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileSetupViewModel());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Using a Flexible with a PageView
            Flexible(
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: controller.totalPages,
                // Disable direct swiping
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  // Return the widget for the current page
                  return _buildPage(index, controller);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Router method to display the correct page
  Widget _buildPage(int index, ProfileSetupViewModel controller) {
    switch (index) {
      case 0:
        return _buildProfileFormPage(controller);
      case 1:
        return _buildGenderPage(controller);
      case 2:
        return _buildAgePage(controller);
      case 3:
        return _buildWeightPage(controller);
      case 4:
        return _buildHeightPage(controller);
      case 5:
        return _buildActivityLevelPage(controller);
      case 6:
        return _buildFitnessGoalsPage(controller);
      default:
        return const Center(child: Text("Page not found"));
    }
  }

  // Common Back/Next button row
  // 
  //,
  // 
  //
 Widget _buildNavigationButtons(
    ProfileSetupViewModel controller,
    bool isSubmit,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Using Expanded to make buttons flexible and of equal width
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              controller.previousPage();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B3B3B), // Dark gray
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.chevron_left, color: Color(0xFFCCFF00)),
                SizedBox(width: 8),
                Text(
                  'Back',
                  style: TextStyle(
                      color: Color(0xFFCCFF00),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 20),
        // Next or Submit Button
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              isSubmit ? controller.submitProfile() : controller.nextPage();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFCCFF00), // Neon green
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  isSubmit ? 'Submit' : 'Next',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.chevron_right, color: Colors.black , ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- UI FOR EACH PAGE ---

  // Page 1: Fill Your Profile (Corrected with Scrolling)
  Widget _buildProfileFormPage(ProfileSetupViewModel controller) {
    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: Colors.grey[800],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );

    // We use a LayoutBuilder and SingleChildScrollView to prevent overflow
    // while keeping the navigation buttons at the bottom.
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          // Make the main content area scrollable
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20), // Top padding
                  Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      'assets/images/kettlebell_logo.png',
                      height: 50,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      "Fill Your Profile",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundColor: AppColors.cardBackground,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor,
                          ),
                          padding: const EdgeInsets.all(4),
                          child: const Icon(
                            Icons.edit,
                            size: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // First + Last Name
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.firstNameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: inputDecoration.copyWith(
                            hintText: "First Name",
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: controller.lastNameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: inputDecoration.copyWith(
                            hintText: "Last Name",
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Email
                  TextField(
                    controller: controller.emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: inputDecoration.copyWith(hintText: "Email"),
                  ),
                  const SizedBox(height: 12),

                  // Phone number (assuming it's part of the form)
                  TextField(
                    controller: controller.phoneController,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(color: Colors.white),
                    decoration: inputDecoration.copyWith(
                      hintText: "Phone Number",
                    ),
                  ),
                  const SizedBox(height: 12),

                  // OTP
                  TextField(
                    controller: controller.otpController,
                    style: const TextStyle(color: Colors.white),
                    decoration: inputDecoration.copyWith(hintText: "OTP"),
                  ),
                  const SizedBox(height: 12),

                  // T&C and Resend
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Obx(
                                () => Checkbox(
                                  value: controller.termsAccepted.value,
                                  onChanged: (value) {
                                    controller.termsAccepted.value =
                                        value ?? false;
                                  },
                                ),
                              ),
                              const Text(
                                "T&C",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Obx(
                                () => Checkbox(
                                  value: controller.privacyAccepted.value,
                                  onChanged: (value) {
                                    controller.privacyAccepted.value =
                                        value ?? false;
                                  },
                                ),
                              ),
                              const Text(
                                "Privacy",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          /* Resend OTP logic */
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: Text(
                            "RESEND OTP",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Keep the navigation buttons fixed at the bottom
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: _buildNavigationButtons(controller, false),
          ),
        ],
      ),
    );
  }

  // Page 2: Gender Selection
  Widget _buildGenderPage(ProfileSetupViewModel controller) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          const Text(
            "Tell Us About Yourself",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "To give you a better experience and results,",
            style: TextStyle(
              color: AppColors.primaryColor.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
          Text(
            "we need to know your gender",
            style: TextStyle(
              color: AppColors.primaryColor.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
          const Spacer(),
          Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildGenderOption(
                  controller,
                  gender: 'Male',
                  icon: Icons.male,
                ),
                const SizedBox(height: 40),
                _buildGenderOption(
                  controller,
                  gender: 'Female',
                  icon: Icons.female,
                ),
              ],
            ),
          ),
          const Spacer(),
          _buildNavigationButtons(controller, false),
        ],
      ),
    );
  }

  Widget _buildGenderOption(
    ProfileSetupViewModel controller, {
    required String gender,
    required IconData icon,
  }) {
    bool isSelected = controller.selectedGender.value == gender;
    return GestureDetector(
      onTap: () => controller.selectedGender.value = gender,
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  isSelected
                      ? AppColors.primaryColor.withOpacity(0.1)
                      : AppColors.cardBackground,
              border: Border.all(
                color: isSelected ? AppColors.primaryColor : Colors.transparent,
                width: 2,
              ),
            ),
            child: Icon(
              icon,
              size: 60,
              color: isSelected ? AppColors.primaryColor : Colors.white,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            gender,
            style: TextStyle(
              color: isSelected ? AppColors.primaryColor : Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Page 3: Age Selector
  Widget _buildAgePage(ProfileSetupViewModel controller) {
    return _buildVerticalSelectorPage(
      controller: controller,
      title: "How old are you?",
      subtitle: "This helps us create your personalized plan",
      itemCount: 83, // Ages 18-100
      itemBuilder: (context, index) {
        final age = index + 18;
        return Obx(() {
          final isSelected = controller.selectedAge.value == age;
          return Center(
            child: Text(
              age.toString(),
              style: TextStyle(
                fontSize: isSelected ? 40 : 32,
                color:
                    isSelected
                        ? AppColors.primaryColor
                        : Colors.white.withOpacity(0.6),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        });
      },
      onSelectedItemChanged: (index) {
        controller.selectedAge.value = index + 18;
      },
      initialItem: controller.selectedAge.value - 18,
    );
  }

  // Page 4: Weight Selector
  Widget _buildWeightPage(ProfileSetupViewModel controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        const Text(
          "What's your weight?",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "You can change this later",
          style: TextStyle(
            color: AppColors.primaryColor.withOpacity(0.7),
            fontSize: 14,
          ),
        ),
        const Spacer(),

        // Weight Picker Section
        NumberSelector(
          minValue: 40,
          maxValue: 120,
          initialValue: controller.selectedWeight.value,
          onChanged: (w) => controller.selectedWeight.value = w,
        ),

        const Spacer(),
        _buildNavigationButtons(controller, false),
      ],
    );
  }

  // Page 5: Height Selector
  Widget _buildHeightPage(ProfileSetupViewModel controller) {
    return _buildVerticalSelectorPage(
      controller: controller,
      title: "What is Your Height?",
      subtitle: "Height is in cm. Don't worry you can always change it later",
      itemCount: 51, // Heights 150-200 cm
      itemBuilder: (context, index) {
        final height = index + 150;
        return Obx(() {
          final isSelected = controller.selectedHeight.value == height;
          return Center(
            child: Text(
              height.toString(),
              style: TextStyle(
                fontSize: isSelected ? 40 : 32,
                color:
                    isSelected
                        ? AppColors.primaryColor
                        : Colors.white.withOpacity(0.6),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        });
      },
      onSelectedItemChanged: (index) {
        controller.selectedHeight.value = index + 150;
      },
      initialItem: controller.selectedHeight.value - 150,
    );
  }

  // Page 6 & 7 use this helper
  Widget _buildOptionsPage({
    required ProfileSetupViewModel controller,
    required String title,
    required String subtitle,
    required List<String> options,
    required bool isMultiSelect,
    required bool isSubmit,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SizedBox(height: 40),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              color: AppColors.primaryColor.withOpacity(0.7),
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children:
                  options.map((option) {
                    final bool isSelected;
                    if (isMultiSelect) {
                      isSelected = controller.fitnessGoals.contains(option);
                    } else {
                      isSelected = controller.activityLevel.value == option;
                    }
                    return _buildOptionButton(
                      text: option,
                      isSelected: isSelected,
                      onTap: () {
                        if (isMultiSelect) {
                          controller.toggleFitnessGoal(option);
                        } else {
                          controller.activityLevel.value = option;
                        }
                      },
                    );
                  }).toList(),
            ),
          ),
          const Spacer(),
          _buildNavigationButtons(controller, isSubmit),
        ],
      ),
    );
  }

  // Reusable button for the last two pages
  Widget _buildOptionButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color:
                isSelected ? AppColors.primaryColor : AppColors.cardBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // Page 6: Physical Activity
  Widget _buildActivityLevelPage(ProfileSetupViewModel controller) {
    return _buildOptionsPage(
      controller: controller,
      title: "Physical Activity Level?",
      subtitle:
          "Choose your regular activity level. This will help us to personalize plans for you.",
      options: ['Beginner', 'Intermediate', 'Advanced'],
      isMultiSelect: false,
      isSubmit: false,
    );
  }

  // Page 7: Fitness Goals
  Widget _buildFitnessGoalsPage(ProfileSetupViewModel controller) {
    return _buildOptionsPage(
      controller: controller,
      title: "How you want to be Fit",
      subtitle:
          "Choose your regular activity level. This will help us to personalize plans for you.",
      options: ['Workout', 'Sports', 'Activities'],
      isMultiSelect: true,
      isSubmit: true,
    );
  }

  // Generic widget for vertical selectors (Age and Height)
  Widget _buildVerticalSelectorPage({
    required ProfileSetupViewModel controller,
    required String title,
    required String subtitle,
    required int itemCount,
    required Widget Function(BuildContext, int) itemBuilder,
    required void Function(int) onSelectedItemChanged,
    required int initialItem,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              color: AppColors.primaryColor.withOpacity(0.7),
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: ListWheelScrollView.useDelegate(
              controller: FixedExtentScrollController(initialItem: initialItem),
              itemExtent: 60,
              perspective: 0.005,
              diameterRatio: 1.5,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: onSelectedItemChanged,
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: itemCount,
                builder: itemBuilder,
              ),
            ),
          ),
          _buildNavigationButtons(controller, false),
        ],
      ),
    );
  }

  Widget _buildInput(String hint) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(30),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
