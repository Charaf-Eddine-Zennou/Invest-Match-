import 'package:flutter/material.dart';
import '../models/user_profile_model.dart';
import '../services/fake_user_db.dart';
import 'dart:convert';

class ShowAllDBScreen extends StatelessWidget {
  const ShowAllDBScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("DB - Tous les utilisateurs")),
      body: FutureBuilder<List<UserProfile>>(
        future: FakeUserService().getAllUsers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final users = snapshot.data!;
          final usersJson = const JsonEncoder.withIndent('  ')
              .convert(users.map((u) => u.toJson()).toList());
          return SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: SelectableText(usersJson, style: const TextStyle(fontFamily: 'monospace', fontSize: 15)),
          );
        },
      )
    );
  }
}
