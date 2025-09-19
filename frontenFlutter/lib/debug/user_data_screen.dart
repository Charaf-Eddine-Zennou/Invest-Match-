import 'package:flutter/material.dart';
import 'dart:convert';
import '../services/fake_user_db.dart';
import '../models/user_profile_model.dart';

class UserDataScreen extends StatelessWidget {
  const UserDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes données"),
        leading: BackButton(),
      ),
      body: FutureBuilder<UserProfile?>(
        future: FakeUserService().getCurrentUser(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final user = snapshot.data;
          if (user == null) {
            return const Center(child: Text("Aucun utilisateur connecté"));
          }
          // Beautify JSON
          final userJson = const JsonEncoder.withIndent('  ').convert(user.toJson());

          return SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: SelectableText(
              userJson,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 15),
            ),
          );
        },
      ),
    );
  }
}
