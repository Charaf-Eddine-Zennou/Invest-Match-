import 'package:flutter/material.dart';
import '../../services/fake_user_db.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'signup_steps/signup_step1_identity.dart';
import '../../main.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onLogin;
  const LoginScreen({super.key, required this.onLogin});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  String email = '', password = '';
  bool loading = false;
  String? loginError;

  void _login() async {
    setState(() => loading = true);

    final user = await FakeUserService().login(email, password);

    setState(() => loading = false);
    if (!mounted) return;

    if (user == null) {
      setState(() {
        loginError = "Identifiant ou mot de passe incorrect";
      });
      return;
    }

    setState(() {
      loginError = null;
    });
    widget.onLogin();
    if (!mounted) return;
    if (Navigator.canPop(context)) Navigator.pop(context);
  }

  void _onForgotPassword() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Mot de passe oublié"),
        content: const Text("Fonctionnalité à venir"),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const darkBlue = Color(0xFF1800AD);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.yellow,
      body: Stack(
        children: [
          // --------- CONTENU CENTRAL ---------
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 12),
                  // ---- NAV BAR ----
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios_new_rounded,
                            color: darkBlue, size: 34),
                        onPressed: () => Navigator.of(context).pop(),
                        splashRadius: 24,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            "Connexion",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w800,
                              fontSize: 28,
                              color: darkBlue,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 40),
                    ],
                  ),
                  const SizedBox(height: 150),
                  // ---- LOGO ----
                  Center(
                    child: SvgPicture.asset(
                      "assets/images/Fundly.svg",
                      width: double.infinity,
                      fit: BoxFit.contain,
                      height: 160,
                    ),
                  ),
                  const SizedBox(height: 48),
                  // ---- CHAMPS EMAIL/ID ----
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Email / identifiant",
                            labelStyle: const TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.black,
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF8F8FF),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Entrez votre email ou identifiant",
                            hintStyle: const TextStyle(
                              color: Color(0xFFBDBDBD),
                              fontFamily: "Poppins",
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: "Poppins",
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                          onChanged: (val) => email = val.trim(),
                          validator: (val) =>
                          val == null || val.isEmpty ? "Obligatoire" : null,
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: "Mot de passe",
                            labelStyle: const TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.black,
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF8F8FF),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Entrez votre mot de passe",
                            hintStyle: const TextStyle(
                              color: Color(0xFFBDBDBD),
                              fontFamily: "Poppins",
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey[500],
                              ),
                              onPressed: () => setState(
                                      () => _obscurePassword = !_obscurePassword),
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: "Poppins",
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                          onChanged: (val) => password = val,
                          validator: (val) =>
                          val == null || val.isEmpty ? "Obligatoire" : null,
                        ),

                        if (loginError != null) ...[
                          Padding(
                            padding: const EdgeInsets.only(left: 6, top: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                loginError!,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 13,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w400,
                                  height: 1.1,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ],

                        // ---- MOT DE PASSE OUBLIÉ ----
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: _onForgotPassword,
                              child: Text(
                                "Mot de passe oublié ?",
                                style: TextStyle(
                                  color: darkBlue,
                                  fontFamily: "Poppins",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          // --------- BOUTON EN BAS ---------
          Positioned(
            left: 0,
            right: 0,
            bottom: 32,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkBlue,
                        foregroundColor: Colors.white,
                        elevation: 4,
                        textStyle: const TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: loading
                          ? null
                          : () {
                        if (_formKey.currentState!.validate()) _login();
                      },
                      child: loading
                          ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : const Text("Se connecter"),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ---- TEXTE INSCRIPTION ----
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Vous n'avez pas de compte ? ",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          pushFadeThrough(
                            context,
                            SignupStep1Identity(),
                          );
                        },
                        child: Text(
                          "Créer un compte",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: darkBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
