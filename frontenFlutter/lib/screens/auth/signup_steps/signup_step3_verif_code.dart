import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../widgets/signup_progress_bar.dart';
import 'package:flutter/services.dart';
import 'signup_step4_profile_choice.dart';
import '../../../main.dart';

class SignupStep3VerifCode extends StatefulWidget {
  final String username;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final String gender;
  final String phone;

  const SignupStep3VerifCode({
    super.key,
    required this.username,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.gender,
    required this.phone,
  });

  @override
  State<SignupStep3VerifCode> createState() => _SignupStep3VerifCodeState();
}

class _SignupStep3VerifCodeState extends State<SignupStep3VerifCode> {
  String code = '';
  bool loading = false;
  String error = '';
  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    const darkBlue = Color(0xFF1800AD);
    return Scaffold(
      backgroundColor: Colors.yellow,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ---- HEADER ----
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios_new_rounded, color: darkBlue, size: 34),
                        onPressed: () => Navigator.of(context).pop(),
                        splashRadius: 24,
                      ),
                      Expanded(
                        child: Center(
                          child: SignupProgressBar(currentStep: 2, totalSteps: 7),
                        ),
                      ),
                      const SizedBox(width: 40),
                    ],
                  ),

                  const SizedBox(height: 140),

                  // ---- CONTENU PRINCIPAL ----
                  Text(
                    "Vérification de l'adresse email",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w800,
                      fontSize: 28,
                      color: darkBlue,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Un code de vérification a été envoyé à",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.email,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 16,
                      color: darkBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 36),

                  // ---- CHAMP A REMPLIR ----
                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    onChanged: (val) => setState(() => code = val),
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    animationType: AnimationType.fade,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(12),
                      fieldHeight: 52,
                      fieldWidth: 44,
                      activeColor: darkBlue,
                      selectedColor: darkBlue.withOpacity(0.7),
                      inactiveColor: Colors.grey[300]!,
                      activeFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      borderWidth: 2,
                    ),
                    enableActiveFill: true,
                    autoFocus: true,
                    showCursor: true,
                  ),
                  if (error.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(error, style: const TextStyle(color: Colors.red)),
                    ),

                  // ----- RESEND -----
                  TextButton(
                    onPressed: loading ? null : () {
                      setState(() {
                        codeSent = true;
                        error = '';
                        // envoi nouveau code
                      });
                      // Simulation envoi
                      Future.delayed(const Duration(seconds: 1), () {
                        setState(() => codeSent = false);
                      });
                    },
                    child: Text(
                      codeSent ? "Code renvoyé !" : "Renvoyer le code",
                      style: TextStyle(
                        color: darkBlue,
                        fontSize: 16,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ---- BOUTON SUIVANT ----
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8, right: 8),
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: FloatingActionButton(
                      backgroundColor: darkBlue,
                      onPressed: () {
                        pushPeerSlide(
                          context,
                          SignupStep4ProfileChoice(
                              username: widget.username,
                              email: widget.email,
                              password: widget.password,
                              firstName: widget.firstName,
                              lastName: widget.lastName,
                              birthDate: widget.birthDate,
                              gender: widget.gender,
                              phone: widget.phone,
                            ),
                        );
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
            )
          ],
        ),
      ),
    );
  }
}
