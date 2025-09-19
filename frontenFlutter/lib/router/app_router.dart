import 'package:flutter/material.dart';
import 'package:nebula_app/models/user_profile_model.dart';
import 'package:nebula_app/services/fake_user_db.dart';
import 'package:nebula_app/screens/public_profile/public_profile_screen.dart';

Route<dynamic>? onGenerateAppRoute(RouteSettings settings) {
  final uri = Uri.parse(settings.name ?? '/');

  // /u/username
  if (uri.pathSegments.length == 2 && uri.pathSegments[0] == 'u') {
    final username = uri.pathSegments[1];
    return MaterialPageRoute(
      builder: (_) => FutureBuilder<UserProfile?>(
        future: FakeUserService().findByEmail('$username@fake.local') /* remplace par findByUsername */,
        builder: (ctx, snap) {
          if (!snap.hasData) return const Scaffold(body: Center(child: CircularProgressIndicator()));
          final profile = snap.data!;
          return PublicProfileScreen(profile: profile);
        },
      ),
      settings: settings,
    );
  }

  // /c/slug (entreprise)
  if (uri.pathSegments.length == 2 && uri.pathSegments[0] == 'c') {
    final slug = uri.pathSegments[1];
    return MaterialPageRoute(
      builder: (_) => FutureBuilder<UserProfile?>(
        future: _findByCompanySlug(slug),
        builder: (ctx, snap) {
          if (!snap.hasData) return const Scaffold(body: Center(child: CircularProgressIndicator()));
          return PublicProfileScreen(profile: snap.data!);
        },
      ),
      settings: settings,
    );
  }

  return null;
}

Future<UserProfile?> _findByCompanySlug(String slug) async {
  final svc = FakeUserService();
  final all = await svc.getAllUsers();
  return all.firstWhere(
        (u) => (u.companyName ?? '').toLowerCase().replaceAll(' ', '-') == slug,
    orElse: () => all.first,
  );
}
