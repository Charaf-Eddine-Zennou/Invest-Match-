import 'package:flutter/material.dart';
import '../../../widgets/signup_progress_bar.dart';
import 'signup_step5_param_investor.dart';
import 'signup_step5_param_entreprise.dart';
import '../../../main.dart';

class SignupStep4ProfileChoice extends StatefulWidget {
  final String username;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final String gender;
  final String phone;

  const SignupStep4ProfileChoice({
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
  State<SignupStep4ProfileChoice> createState() => _SignupStep4ProfileChoiceState();
}

class _SignupStep4ProfileChoiceState extends State<SignupStep4ProfileChoice> {
  String? profileType;
  String? investorLevel;
  bool showError = false;

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
                      child: SignupProgressBar(currentStep: 3, totalSteps: 7),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),

              const SizedBox(height: 180),

              // ---- CONTENU PRINCIPAL ----
              Text(
                "Vous êtes ?",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w800,
                  fontSize: 28,
                  color: darkBlue,
                ),
              ),
              const SizedBox(height: 28),

              // ---- CHAMPS A REMPLIR ----
              customRadio(
                label: "Investisseur",
                selected: profileType == "investisseur",
                onTap: () => setState(() {
                  profileType = "investisseur";
                  investorLevel = null;
                }),
              ),
              customRadio(
                label: "Entreprise",
                selected: profileType == "entreprise",
                onTap: () => setState(() {
                  profileType = "entreprise";
                  investorLevel = null;
                }),
              ),

              if (profileType == "investisseur") ...[
                const SizedBox(height: 12),
                Divider(
                  color: darkBlue,
                  thickness: 1,
                  height: 10,
                ),
                const SizedBox(height: 12),

                const SizedBox(height: 10),
                customRadio(
                  label: "Tout nouveau",
                  selected: investorLevel == "nouveau",
                  onTap: () => setState(() => investorLevel = "nouveau"),
                ),
                customRadio(
                  label: "Expérimenté",
                  selected: investorLevel == "expérimenté",
                  onTap: () => setState(() => investorLevel = "expérimenté"),
                ),
                customRadio(
                  label: "Business angel",
                  selected: investorLevel == "business_angel",
                  onTap: () => setState(() => investorLevel = "business_angel"),
                ),
              ],

              if (showError)
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 2, bottom: 8),
                  child: Text(
                    profileType == null
                        ? "Sélectionnez une option pour continuer."
                        : "Sélectionnez votre niveau d'expérience.",
                    style: TextStyle(
                      color: Colors.red[700],
                      fontFamily: "Poppins",
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
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
                      onPressed: (profileType == null ||
                          (profileType == "investisseur" && investorLevel == null))
                          ? () {
                        setState(() => showError = true);
                      }
                          : () {
                        setState(() => showError = false);

                        if (profileType == "investisseur") {
                          pushPeerSlide(
                            context,
                            SignupStep5ParamInvestor(
                              username: widget.username,
                              email: widget.email,
                              password: widget.password,
                              firstName: widget.firstName,
                              lastName: widget.lastName,
                              birthDate: widget.birthDate,
                              gender: widget.gender,
                              phone: widget.phone,
                              profileType: profileType!,
                              investorLevel: investorLevel,
                            ),
                          );
                        } else if (profileType == "entreprise") {
                          pushPeerSlide(
                            context,
                            SignupStep5ParamEntreprise(
                              username: widget.username,
                              email: widget.email,
                              password: widget.password,
                              firstName: widget.firstName,
                              lastName: widget.lastName,
                              birthDate: widget.birthDate,
                              gender: widget.gender,
                              phone: widget.phone,
                              profileType: profileType!,
                            ),
                          );
                        }
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

  // ---- Widget boutons radio ----
  Widget customRadio({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        decoration: BoxDecoration(
          color: selected ? Color(0xFFEDEBFF) : Color(0xFFF8F8FF),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? Color(0xFF1800AD) : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            if (selected)
              BoxShadow(
                color: Color(0xFF1800AD).withOpacity(0.08),
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: selected ? Color(0xFF1800AD) : Colors.grey[400],
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

