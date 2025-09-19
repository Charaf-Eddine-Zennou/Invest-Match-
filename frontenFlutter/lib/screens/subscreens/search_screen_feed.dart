import 'package:flutter/material.dart';

class SearchScreenFeed extends StatelessWidget {
  const SearchScreenFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔍 Barre de recherche
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3EEF9),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 4),

                    // ⬅️ Bouton retour
                    Material(
                      color: Colors.transparent,
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () => Navigator.pop(context),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.arrow_back, color: Colors.black),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Champ de recherche
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Rechercher',
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none,
                          isCollapsed: true,
                        ),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),

                    // ☰ Bouton filtre
                    Material(
                      color: Colors.transparent,
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () {
                          // TODO: ouvrir filtres
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.menu, color: Colors.black87),
                        ),
                      ),
                    ),

                    const SizedBox(width: 4),
                  ],
                ),
              ),
            ),


           /* // 🔁 Recherches récentes
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Recherches récentes',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Green Future Solutions', style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 6),
                  Text('Tech Invest', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),

            // Entreprise du mois
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Text(
                'Notre entreprise du mois',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF3D3B6D)),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/company_placeholder.png',
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Les plus likées
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Text(
                'Les plus aimées',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF3D3B6D)),
              ),
            ),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/company_placeholder.png',
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
