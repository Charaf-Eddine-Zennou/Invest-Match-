import 'package:flutter/material.dart';

class SearchScreenLearn extends StatelessWidget {
  const SearchScreenLearn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                // 🔍 Barre de recherche
                Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3EEF9),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 4),
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
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Rechercher',
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none,
                            isCollapsed: true,
                          ),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
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
                            child: Icon(Icons.menu, color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                    ],
                  ),
                ),


                // 🔁 Recherches récentes
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Recherches récentes',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Investissements éthiques', style: TextStyle(color: Colors.grey)),
                      SizedBox(height: 6),
                      Text('Quizz ISR débutant', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
