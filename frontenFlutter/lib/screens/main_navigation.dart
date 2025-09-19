import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'home_screen.dart';
import 'feed_screen.dart';
import 'messages_screen.dart';
import 'profile_screen.dart';

import '../services/fake_user_db.dart';
import '../models/user_profile_model.dart';

class MainNavigation extends StatefulWidget {
  final VoidCallback onLogout;
  const MainNavigation({super.key, required this.onLogout});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  late List<Widget> _screens;

  UserProfile? _currentUser;
  bool _loadingUser = true;

  @override
  void initState() {
    super.initState();
    _initUser();
    _screens = const [
      HomeScreen(),
      FeedScreen(),
      MessagesScreen(),
      SizedBox.shrink(),
    ];
  }

  Future<void> _initUser() async {
    final svc = FakeUserService();
    var u = await svc.getCurrentUser();

    if (u == null) {
      u = UserProfile(
        id: 'u_demo',
        username: 'd',
        email: 'd@example.com',
        password: 'demo',
        firstName: 'D',
        lastName: 'Nebula',
        birthDate: DateTime(2008, 1, 1),
        gender: 'M',
        phone: '+33 600000000',
        profileType: 'investisseur',
        investorLevel: 'avancé',
        sectors: const ['Restauration'],
        companyName: null,
        siret: null,
        address: 'Paris',
        domain: 'nebula.app',
        notificationsEnabled: true,
        bio: 'Build. Ship. Iterate.',
        profileImage: 'https://i.pravatar.cc/150?img=15',
        followers: 628,
        following: 73,
        isVerified: true,
      );
      await svc.addUser(u);
      await svc.login(u.email, u.password);
    }

    setState(() {
      _currentUser = u;
      _loadingUser = false;
      _screens = [
        const HomeScreen(),
        const FeedScreen(),
        const MessagesScreen(),
        ProfileScreen(onLogout: _handleLogout),
      ];
    });
  }

  Future<void> _handleLogout() async {
    await FakeUserService().logout();
    setState(() {
      _currentUser = null;
      _loadingUser = true;
    });
    await _initUser();
    widget.onLogout();
  }

  @override
  Widget build(BuildContext context) {
    const Color kPrimary = Color(0xFF1C15BC);
    const Color kNavBarBackground = Colors.white;
    const Color kUnselected = Color(0xFFBDBDBD);

    if (_loadingUser) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: kNavBarBackground,
            border: Border(top: BorderSide(color: Color(0xFFEDEDED), width: 1)),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            backgroundColor: kNavBarBackground,
            onTap: (index) => setState(() => _selectedIndex = index),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: kPrimary,
            unselectedItemColor: kUnselected,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            iconSize: 28,
            items: [
              BottomNavigationBarItem(
                icon: const SizedBox.square(dimension: 32, child: Icon(LucideIcons.home)),
                activeIcon: const SizedBox.square(dimension: 32, child: Icon(LucideIcons.home, color: kPrimary)),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: const SizedBox.square(dimension: 32, child: Icon(LucideIcons.lightbulb)),
                activeIcon: const SizedBox.square(dimension: 32, child: Icon(LucideIcons.lightbulb, color: kPrimary)),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: const SizedBox.square(dimension: 32, child: Icon(LucideIcons.messageCircle)),
                activeIcon: const SizedBox.square(dimension: 32, child: Icon(LucideIcons.messageCircle, color: kPrimary)),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: const SizedBox.square(dimension: 32, child: Icon(LucideIcons.user)),
                activeIcon: const SizedBox.square(dimension: 32, child: Icon(LucideIcons.user, color: kPrimary)),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
