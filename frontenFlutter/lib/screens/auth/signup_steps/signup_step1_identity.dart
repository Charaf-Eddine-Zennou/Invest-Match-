import 'package:flutter/material.dart';
import '../../../widgets/signup_progress_bar.dart';
import 'signup_step2_infos.dart';
import '../../../main.dart';

class SignupStep1Identity extends StatefulWidget {
  const SignupStep1Identity({super.key});


  @override
  State<SignupStep1Identity> createState() => _SignupStep1IdentityState();
}

class _SignupStep1IdentityState extends State<SignupStep1Identity> {
  final _formKey = GlobalKey<FormState>();
  String username = '', email = '', password = '', confirm = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    const darkBlue = Color(0xFF1800AD);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.yellow,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ---- HEADER ----
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
                      child: SignupProgressBar(currentStep: 0, totalSteps: 7),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),

              const SizedBox(height: 180),

              // ---- CONTENU PRINCIPAL ----
              Text(
                "Créer un compte",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w800,
                  fontSize: 28,
                  color: darkBlue,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 38),

              // ---- CHAMPS A REMPLIR ----
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Nom d'utilisateur",
                        prefixText: "@",
                        prefixStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins",
                          fontSize: 18,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Color(0xFFF8F8FF),
                        filled: true,
                      ),
                      onChanged: (val) => setState(() => username = val.trim()),
                      validator: (val) => val == null || val.isEmpty
                          ? "Obligatoire"
                          : null,
                    ),

                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Adresse email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Color(0xFFF8F8FF),
                        filled: true,
                      ),
                      onChanged: (val) => setState(() => email = val.trim()),
                      validator: (val) => val == null || !val.contains("@")
                          ? "Email invalide"
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Mot de passe",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Color(0xFFF8F8FF),
                        filled: true,
                      ),
                      obscureText: true,
                      onChanged: (val) => setState(() => password = val),
                      validator: (val) => val == null || val.length < 6
                          ? "6 caractères minimum"
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Confirmer le mot de passe",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Color(0xFFF8F8FF),
                        filled: true,
                      ),
                      obscureText: true,
                      onChanged: (val) => setState(() => confirm = val),
                      validator: (val) =>
                      val != password ? "Les mots de passe ne correspondent pas" : null,
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // ---- BOUTON SUIVANT ----
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8, right: 8),
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: FloatingActionButton(
                      backgroundColor: darkBlue,

                      // ---- PAGE SUIVANTE ----
                      onPressed: loading
                          ? null
                          : () {
                        if (_formKey.currentState!.validate()) {
                          pushPeerSlide(
                            context,
                            SignupStep2Infos(
                                username: username,
                                email: email,
                                password: password,
                            ),
                          );
                        }
                      },
                      shape: const CircleBorder(),
                      elevation: 4,
                      child: loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
