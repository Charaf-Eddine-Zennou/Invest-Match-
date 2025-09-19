import 'package:flutter/material.dart';

import '../models/user_profile_model.dart';
import '../services/fake_user_db.dart';

import '../main.dart';
import 'profile_manage/profile_manage_screen.dart';

import 'package:nebula_app/screens/subscreens/settings_screen.dart';
import 'package:nebula_app/widgets/profile/profile_header_card.dart';
import 'package:nebula_app/widgets/profile/profile_section_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.onLogout,
    this.user,
  });

  final VoidCallback onLogout;
  final UserProfile? user;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProfile? _user;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _user = widget.user;
      _loading = false;
    } else {
      _loadUser();
    }
  }

  Future<void> _loadUser() async {
    final svc = FakeUserService();
    var u = await svc.getCurrentUser();

    u ??= UserProfile(
      id: 'u_demo',
      username: 'd',
      email: 'd@example.com',
      password: 'demo',
      firstName: 'D',
      lastName: 'Nebula',
      birthDate: DateTime(2008, 1, 1),
      gender: 'M',
      phone: '+33 600000000',
      profileType: 'entreprise',
      investorLevel: null,
      sectors: const [],
      companyName: 'Nebula',
      siret: '123 456 789 00012',
      address: 'Paris',
      domain: 'nebula.app',
      notificationsEnabled: true,
      bio: 'Build. Ship. Iterate.',
      profileImage: 'https://i.pravatar.cc/150?img=15',
      followers: 628,
      following: 73,
      isVerified: true,
    );

    if (!mounted) return;
    setState(() {
      _user = u!;
      _loading = false;
    });
  }

  bool get _isInvestor =>
      (_user?.profileType.toLowerCase() ?? '') == 'investisseur';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        actions: [
          IconButton(
            tooltip: 'Paramètres',
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => pushPeerSlide(
              context,
              SettingsScreen(onLogout: widget.onLogout),
            ),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: _loadUser,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
          child: Column(
            children: [
              // ---- Header imposant, tappable ----
              ProfileHeaderCard(
                user: _user!,
                height: 236, // plus massif
                onTap: () => pushPeerSlide(context, ProfileManageScreen(me: _user!)),
              ),
              const SizedBox(height: 16),

              // ---- Sections ----
              ProfileSectionButton(
                title: 'Mon showroom',
                subtitle: 'Portfolio / investissements',
                onTap: () => pushPeerSlide(context, const PlaceholderScreen(title: 'Showroom')),
              ),
              const SizedBox(height: 12),
              ProfileSectionButton(
                title: 'Mon activité',
                subtitle: 'Likes, commentaires, interactions',
                onTap: () => pushPeerSlide(context, const PlaceholderScreen(title: 'Activité')),
              ),
              const SizedBox(height: 12),
              ProfileSectionButton(
                title: 'Ma dataroom',
                subtitle: _isInvestor
                    ? 'Suivis, tickets, intérêts'
                    : 'Campagnes et progrès',
                onTap: () => pushPeerSlide(context, PlaceholderScreen(title: _isInvestor ? 'Mes invests' : 'Mes levées')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(title)), body: const Center(child: Text('Coming soon…')));
  }
}

/// Demo
class _FullProfileGate extends StatelessWidget {
  const _FullProfileGate({required this.user});
  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.companyName?.isNotEmpty == true ? user.companyName! : '${user.firstName} ${user.lastName}')),
      body: const Center(child: Text('Profil complet / édition à venir')),
    );
  }
}
