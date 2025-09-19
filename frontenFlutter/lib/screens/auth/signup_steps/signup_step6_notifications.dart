import 'package:flutter/material.dart';
import '../../../widgets/signup_progress_bar.dart';
import 'signup_step7_welcome.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../main.dart';

class SignupStep6Notifications extends StatefulWidget {
  final String username;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final String gender;
  final String phone;
  final String profileType;
  final String? investorLevel; // null si entreprise
  final List<String> sectors; // vide si entreprise

  // Champs spécifiques entreprise (null si investisseur)
  final String? companyName;
  final String? siret;
  final String? address;
  final String? domain;

  const SignupStep6Notifications({
    super.key,
    required this.username,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.gender,
    required this.phone,
    required this.profileType,
    this.investorLevel,
    required this.sectors,
    this.companyName,
    this.siret,
    this.address,
    this.domain,
  });

  @override
  State<SignupStep6Notifications> createState() => _SignupStep6NotificationsState();
}


class _SignupStep6NotificationsState extends State<SignupStep6Notifications> {
  @override
  Widget build(BuildContext context) {
    const darkBlue = Color(0xFF1800AD);

    return Scaffold(
      backgroundColor: Colors.yellow,
      resizeToAvoidBottomInset: false,
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
                    icon: Icon(Icons.arrow_back_ios_new_rounded, color: darkBlue, size: 34),
                    onPressed: () => Navigator.of(context).pop(),
                    splashRadius: 24,
                  ),
                  Expanded(
                    child: Center(
                      child: SignupProgressBar(currentStep: 5, totalSteps: 7),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),

              const SizedBox(height: 180),
              // ---- TITRE ----
              Text(
                "Activez les notifications",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w800,
                  fontSize: 36,
                  color: darkBlue,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 18),
              // ---- SOUS-TITRE ----
              Text(
                "Pour surveiller vos investissements \nen temps réel",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              // ---- BOUTON OUI ----
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkBlue,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () async {
                    // Permission notifications (iOS et Android 13+)
                    final status = await Permission.notification.request();

                    if (!mounted) return;
                    if (status.isGranted) {
                      pushPeerSlide(
                        context,
                        SignupStep7Welcome(
                          username: widget.username,
                          email: widget.email,
                          password: widget.password,
                          firstName: widget.firstName,
                          lastName: widget.lastName,
                          birthDate: widget.birthDate,
                          gender: widget.gender,
                          phone: widget.phone,
                          profileType: widget.profileType,
                          investorLevel: widget.investorLevel,
                          sectors: widget.sectors,

                          companyName: widget.companyName,
                          siret: widget.siret,
                          address: widget.address,
                          domain: widget.domain,

                          notificationsEnabled: true,
                        ),

                      );
                    } else {
                      pushPeerSlide(
                        context,
                        SignupStep7Welcome(
                          username: widget.username,
                          email: widget.email,
                          password: widget.password,
                          firstName: widget.firstName,
                          lastName: widget.lastName,
                          birthDate: widget.birthDate,
                          gender: widget.gender,
                          phone: widget.phone,
                          profileType: widget.profileType,
                          investorLevel: widget.investorLevel,

                          sectors: widget.sectors,

                          companyName: widget.companyName,
                          siret: widget.siret,
                          address: widget.address,
                          domain: widget.domain,

                          notificationsEnabled: false,
                        ),

                      );
                    }
                  },
                  child: const Text("Oui"),
                ),
              ),
              const SizedBox(height: 16),
              // ---- BOUTON "PLUS TARD" ----
              Center(
                child: GestureDetector(
                  onTap: () {
                    pushPeerSlide(
                      context,
                      SignupStep7Welcome(
                        username: widget.username,
                        email: widget.email,
                        password: widget.password,
                        firstName: widget.firstName,
                        lastName: widget.lastName,
                        birthDate: widget.birthDate,
                        gender: widget.gender,
                        phone: widget.phone,
                        profileType: widget.profileType,
                        investorLevel: widget.investorLevel,
                        sectors: widget.sectors,

                        companyName: widget.companyName,
                        siret: widget.siret,
                        address: widget.address,
                        domain: widget.domain,

                        notificationsEnabled: false,
                      ),

                    );
                  },
                  child: Text(
                    "Plus tard",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: darkBlue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decorationColor: Colors.grey[300],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 44),
            ],
          ),
        ),
      ),
    );
  }
}
