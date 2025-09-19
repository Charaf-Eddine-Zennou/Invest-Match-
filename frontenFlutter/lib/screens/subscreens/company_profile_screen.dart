import 'package:flutter/material.dart';
import '../../models/company_profile_model.dart';
import '../../widgets/company_progress_bar.dart';

const double avatarRadius = 48;

class TestCompanyProfileScreen extends StatelessWidget {
  const TestCompanyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final company = CompanyProfile(
      name: "Green Future Solutions",
      handle: "GFS",
      description:
      "Pionnier des énergies renouvelables 🌱 pour un avenir durable - rejoignez notre mission !",
      profileImage: "assets/images/company_placeholder.png",
      bannerImage: "assets/images/company_placeholder.png",
      followers: 9,
      publications: 3,
      investmentProgress: 1.0,
      investmentAmount: "€250k",
      websiteUrl: "https://example.com",
      linkedinUrl: "https://linkedin.com/company/example",
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // topbar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Text('@${company.handle}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {}, // menu plus tard
                  ),
                ],
              ),
            ),

            // Bannière + avatar
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Bannière avec hauteur 5x le rayon
                Image.asset(
                  company.bannerImage,
                  height: avatarRadius * 4,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                // Avatar centré en bas de la bannière
                Positioned(
                  bottom: avatarRadius, // moitié en-dessous
                  left: 0,
                  right: 0,
                  child: Center(
                    child: CircleAvatar(
                      radius: avatarRadius,
                      backgroundImage: AssetImage(company.profileImage),
                    ),
                  ),
                ),
              ],
            ),


            const SizedBox(height: avatarRadius),

            // Infos entreprise
            Text(company.name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 4),
            Text('${company.followers} abonnés   ${company.publications} publications',
                style: TextStyle(color: Colors.grey.shade600)),
            const SizedBox(height: 12),

            // Barre de progression
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: const CompanyProgressBar(
                progress: 0.85,
                amount: "€250k",
              ),
            ),

            const SizedBox(height: 12),

            // Bio
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                company.description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
            ),

            const SizedBox(height: 16),

            // Boutons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {}, // suivre
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text(
                    "S’abonner",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  onPressed: () {}, // LinkedIn
                  icon: const Icon(Icons.business_center),
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    backgroundColor: Colors.grey.shade300,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {}, // site web
                  icon: const Icon(Icons.language),
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    backgroundColor: Colors.grey.shade300,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Réels (images statiques pour l'instant)
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                children: List.generate(
                  6,
                      (index) => GestureDetector(
                    onTap: () {}, // réel
                    child: Image.asset(
                      'assets/images/company_placeholder.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
