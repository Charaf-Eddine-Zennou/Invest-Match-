import 'package:flutter/material.dart';

class SignupProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final Color activeColor;
  final Color inactiveColor;

  const SignupProgressBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.activeColor = const Color(0xFF1800AD),
    this.inactiveColor = const Color(0xFFD3D3D3),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          totalSteps,
              (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 18,
            height: 4,
            decoration: BoxDecoration(
              color: index <= currentStep ? activeColor : inactiveColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),
    );
  }
}
