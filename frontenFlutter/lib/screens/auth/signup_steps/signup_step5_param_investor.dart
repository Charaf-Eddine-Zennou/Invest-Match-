import 'package:flutter/material.dart';
import '../../../widgets/signup_progress_bar.dart';
import 'signup_step6_notifications.dart';
import '../../../main.dart';

class SignupStep5ParamInvestor extends StatefulWidget {
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

  const SignupStep5ParamInvestor({
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
  });

  @override
  State<SignupStep5ParamInvestor> createState() => _SignupStep5ParamInvestor();
}

class _SignupStep5ParamInvestor extends State<SignupStep5ParamInvestor> {
  List<String> selectedSectors = [];
  final List<String> allSectors = [
    "Restauration",
    "Commerce de détail",
    "Commerce de gros",
    "Beauté",
    "Construction",
    "Transport",
    "Loisirs",
    "Services",
    "Technologie",
    "Santé",
  ];

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
                      child: SignupProgressBar(currentStep: 4, totalSteps: 7),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // ---- PASSER (sans secteurs sélectionnés) ----
                      pushPeerSlide(
                        context,
                        SignupStep6Notifications(
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

                            sectors: [],

                            companyName: null,
                            siret: null,
                            address: null,
                            domain: null,
                        ),
                      );
                    },
                    child: Text(
                      "Passer",
                      style: TextStyle(
                        color: darkBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),
              // ---- TITRE ----
              Text(
                "Dites-nous en plus",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w800,
                  fontSize: 28,
                  color: darkBlue,
                ),
              ),
              const SizedBox(height: 18),
              // ---- SOUS-TITRE ----
              Text(
                "Secteurs qui vous intéressent",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),

              // ---- BULLES SECTEURS ----
              Wrap(
                spacing: 10,
                runSpacing: 6,
                children: allSectors.map((sector) {
                  final selected = selectedSectors.contains(sector);
                  return ChoiceChip(
                    label: Text(
                      sector,
                      style: TextStyle(
                        color: selected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins",
                      ),
                    ),
                    selected: selected,
                    onSelected: (val) {
                      setState(() {
                        if (selected) {
                          selectedSectors.remove(sector);
                        } else {
                          selectedSectors.add(sector);
                        }
                      });
                    },
                    selectedColor: darkBlue,
                    backgroundColor: Color(0xFFF8F8FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  );
                }).toList(),
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
                      onPressed: selectedSectors.isEmpty
                          ? null
                          : () {
                        // ---- PAGE SUIVANTE ----
                        pushPeerSlide(
                          context,
                          SignupStep6Notifications(
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
                              sectors: selectedSectors,

                              companyName: null,
                              siret: null,
                              address: null,
                              domain: null,
                          ),
                        );
                      },
                      shape: const CircleBorder(),
                      elevation: 4,
                      child: const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 30),
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


