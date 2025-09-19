import 'package:flutter/material.dart';

class SocialIconButton extends StatelessWidget {
  final IconData icon; final VoidCallback onTap;
  const SocialIconButton({super.key, required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap, radius: 28,
      child: Container(
        width: 44, height: 44,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 22),
      ),
    );
  }
}
