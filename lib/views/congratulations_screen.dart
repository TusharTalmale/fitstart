import 'package:flutter/material.dart';

class CongratulationsScreen extends StatelessWidget {
  const CongratulationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Decorative Confetti-like icons
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: const [
                    Icon(Icons.emoji_objects, color: Colors.limeAccent),
                    Icon(Icons.star, color: Colors.white),
                    Icon(Icons.circle, size: 12, color: Colors.limeAccent),
                    Icon(Icons.star_border, color: Colors.limeAccent),
                    Icon(Icons.emoji_objects, color: Colors.white),
                    Icon(Icons.star, color: Colors.limeAccent),
                    Icon(Icons.circle, size: 12, color: Colors.white),
                    Icon(Icons.star_border, color: Colors.white),
                  ],
                ),
                const SizedBox(height: 40),

                const Text(
                  "Congratulation",
                  style: TextStyle(
                    color: Colors.limeAccent,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                const Text(
                  "Your Profile Has Been Created!",
                  style: TextStyle(
                    color: Colors.limeAccent,
                    fontSize: 14,
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
