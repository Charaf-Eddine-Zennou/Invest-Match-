import 'package:shared_preferences/shared_preferences.dart';
import '../../../widgets/signup_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../main_navigation.dart';
import '../../../services/fake_user_db.dart';
import '../../../models/user_profile_model.dart';

class SignupStep7Welcome extends StatelessWidget {
  final String username;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final String gender;
  final String phone;
  final String profileType;
  final String? investorLevel;
  final List<String> sectors;
  final bool notificationsEnabled;

  final String? companyName;
  final String? siret;
  final String? address;
  final String? domain;

  const SignupStep7Welcome({
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
    required this.notificationsEnabled,

    this.companyName,
    this.siret,
    this.address,
    this.domain,
  });

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
                      child: SignupProgressBar(currentStep: 6, totalSteps: 7),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),

              const SizedBox(height: 180),
              // ---- BIENVENUE ET LOGO ----
              Text(
                "Bienvenue sur",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w800,
                  fontSize: 40,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              Center(
                child: Image.asset(
                  "assets/images/fundly_nb.png",
                  width: double.infinity,
                  height: 120,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),
              SvgPicture.asset(
                'assets/images/Fundly.svg',
                width: 120,
                height: 120,
                fit: BoxFit.contain,
              ),
              const Spacer(),

              // ---- BOUTON ----
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
                    final newUser = UserProfile(
                      id: UniqueKey().toString(),
                      username: username,
                      email: email,
                      password: password,
                      bio: '',
                      profileImage: '',
                      followers: 0,
                      following: 0,
                      isVerified: false,
                      firstName: firstName,
                      lastName: lastName,
                      birthDate: birthDate,
                      gender: gender,
                      phone: phone,
                      profileType: profileType,
                      investorLevel: investorLevel,
                      sectors: sectors,
                      notificationsEnabled: notificationsEnabled,
                      companyName: companyName,
                      siret: siret,
                      address: address,
                      domain: domain,
                    );

                    await FakeUserService().addUser(newUser);

                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('email', email);

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MainNavigation(
                          onLogout: () {},
                        ),
                      ),
                          (route) => false,
                    );
                  },


                  child: const Text("Commencez à explorer"),
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
