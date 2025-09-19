import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Notifications",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "Aucune nouvelle notification",
          style: TextStyle(
            color: Colors.grey,
            fontFamily: "Inter",
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}