import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'signup_steps/signup_step1_identity.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../main.dart';

class AuthChoiceScreen extends StatelessWidget {
  final VoidCallback onLogin;
  const AuthChoiceScreen({super.key, required this.onLogin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: SafeArea(
        child: Stack(
          children: [
            // ----LOGO  ----
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/images/Fundly.svg',
                      width: 120,
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 20),
                    Image.asset(
                      "assets/images/fundly_nb.png",
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),

            // ---- SLOGAN ----
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 170.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 210),
                    Text(
                      "Un scroll. Une rencontre.\nUn futur.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ---- BOUTONS EN BAS ----
            Positioned(
              left: 0,
              right: 0,
              bottom: 24,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 64,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1800AD),
                          foregroundColor: Colors.white,
                          elevation: 6,
                          textStyle: const TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () => pushFadeThrough(
                          context,
                          LoginScreen(onLogin: onLogin),
                        ),
                        child: const Text("Se connecter"),
                      ),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      height: 64,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.white,
                          elevation: 2,
                          textStyle: const TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () => pushFadeThrough(
                          context,
                          SignupStep1Identity(),
                        ),
                        child: const Text(
                          "Créer un compte",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                            color: Color(0xFF1800AD),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

