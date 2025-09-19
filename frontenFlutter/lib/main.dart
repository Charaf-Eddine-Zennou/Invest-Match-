import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/auth/auth_choice_screen.dart';
import 'screens/main_navigation.dart';
import 'services/fake_user_db.dart';
import 'package:animations/animations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FakeUserService().loadUsers();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getString('email') != null;
  runApp(NebulaApp(isLoggedIn: isLoggedIn));
}

class NebulaApp extends StatefulWidget {
  final bool isLoggedIn;
  const NebulaApp({super.key, required this.isLoggedIn});

  @override
  State<NebulaApp> createState() => _NebulaAppState();
}

void pushFadeThrough(BuildContext context, Widget page) {
  Navigator.of(context).push(PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeThroughTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        fillColor: Colors.yellow,
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 200),
  ));
}

void pushNoAnimation(BuildContext context, Widget page) {
  Navigator.of(context).push(PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
    transitionDuration: Duration.zero,
    reverseTransitionDuration: Duration.zero,
  ));
}

void pushPeerSlide(
    BuildContext context,
    Widget page, {
      bool rootNavigator = false,
    }) {
  Navigator.of(context, rootNavigator: rootNavigator).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
          fillColor: Colors.transparent,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      reverseTransitionDuration: const Duration(milliseconds: 200),
    ),
  );
}


class _NebulaAppState extends State<NebulaApp> {
  late bool _isLoggedIn;

  @override
  void initState() {
    super.initState();
    _isLoggedIn = widget.isLoggedIn;
  }

  void handleLogin() {
    setState(() {
      _isLoggedIn = true;
    });
  }

  void handleLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    setState(() {
      _isLoggedIn = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fundly',
      theme: ThemeData.light(),
      routes: {
        '/main': (context) => MainNavigation(onLogout: handleLogout),
      },
      home: _isLoggedIn
          ? MainNavigation(onLogout: handleLogout)
          : AuthChoiceScreen(onLogin: handleLogin),
    );
  }
}
