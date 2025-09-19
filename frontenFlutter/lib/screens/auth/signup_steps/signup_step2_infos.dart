import 'package:flutter/material.dart';
import '../../../widgets/signup_progress_bar.dart';
import 'signup_step3_verif_code.dart';
import '../../../main.dart';

class SignupStep2Infos extends StatefulWidget {
  final String username;
  final String email;
  final String password;

  const SignupStep2Infos({
    super.key,
    required this.username,
    required this.email,
    required this.password,
  });


  @override
  State<SignupStep2Infos> createState() => _SignupStep2InfosState();
}

class _SignupStep2InfosState extends State<SignupStep2Infos> {
  final _formKey = GlobalKey<FormState>();
  String firstName = '', lastName = '';
  DateTime? birthDate;
  String phone = '';
  String gender = '';
  bool loading = false;

  final Color darkBlue = const Color(0xFF1800AD);

  @override
  Widget build(BuildContext context) {
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
                          child: SignupProgressBar(currentStep: 1, totalSteps: 7),
                        ),
                      ),
                      const SizedBox(width: 40),
                    ],
                  ),
                  const SizedBox(height: 140),

                  // ---- CONTENU PRINCIPAL ----
                  Text(
                    "Informations complémentaires",
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
                            labelText: "Prénom",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: const Color(0xFFF8F8FF),
                            filled: true,
                          ),
                          onChanged: (val) => setState(() => firstName = val.trim()),
                          validator: (val) => val == null || val.isEmpty ? "Obligatoire" : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Nom",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: const Color(0xFFF8F8FF),
                            filled: true,
                          ),
                          onChanged: (val) => setState(() => lastName = val.trim()),
                          validator: (val) => val == null || val.isEmpty ? "Obligatoire" : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Numéro de téléphone (facultatif)",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: const Color(0xFFF8F8FF),
                            filled: true,
                          ),
                          keyboardType: TextInputType.phone,
                          onChanged: (val) => setState(() => phone = val.trim()),
                          validator: (val) {
                            if (val == null || val.isEmpty) return null;
                            final pattern = RegExp(r"^0\d{9}$");
                            if (!pattern.hasMatch(val)) {
                              return "Numéro invalide";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime(2005, 1, 1),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now().subtract(const Duration(days: 365 * 13)),
                            );
                            if (picked != null) setState(() => birthDate = picked);
                          },

                          child: AbsorbPointer(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "Date de naissance",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                                fillColor: const Color(0xFFF8F8FF),
                                filled: true,
                              ),
                              controller: TextEditingController(
                                text: birthDate == null
                                    ? ""
                                    : "${birthDate!.day.toString().padLeft(2, '0')}/${birthDate!.month.toString().padLeft(2, '0')}/${birthDate!.year}",
                              ),
                              validator: (val) => birthDate == null ? "Obligatoire" : null,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _genderChip("F", "Féminin", gender == "F"),
                            const SizedBox(width: 20),
                            _genderChip("H", "Masculin", gender == "H"),
                            const SizedBox(width: 20),
                            _genderChip("A", "Autre", gender == "A"),
                          ],
                        ),

                        const SizedBox(height: 8),
                        if (gender.isEmpty)
                          const Text(
                            "Sélectionnez votre genre",
                            style: TextStyle(color: Colors.red, fontSize: 13),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

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

                      // ---- PAGE SUIVANTE ----
                      onPressed: () {
                        if (_formKey.currentState!.validate() && gender.isNotEmpty) {
                          pushPeerSlide(
                            context,
                            SignupStep3VerifCode(
                                username: widget.username,
                                email: widget.email,
                                password: widget.password,
                                firstName: firstName,
                                lastName: lastName,
                                birthDate: birthDate!,
                                gender: gender,
                                phone: phone,
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
            )
          ],
        ),
      ),
    );
  }

  // ---- Widget de choix de genre ----
  Widget _genderChip(String code, String label, bool selected) {
    final Color darkBlue = const Color(0xFF1800AD);
    return GestureDetector(
      onTap: () => setState(() => gender = code),
      child: Column(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selected ? darkBlue : Colors.white,
              border: Border.all(color: darkBlue, width: 2),
            ),
            alignment: Alignment.center,
            child: Text(
              label.substring(0,1),
              style: TextStyle(
                color: selected ? Colors.white : darkBlue,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                fontFamily: "Poppins",
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: darkBlue,
              fontSize: 13,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
