import 'package:flutter/material.dart';

class SearchScreenMessages extends StatelessWidget {
  const SearchScreenMessages({super.key});

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

                // Barre de recherche
                Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3EEF9),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
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
                              hintText: 'Rechercher un contact',
                              hintStyle: TextStyle(color: Colors.black54),
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),


                // 🔁 Recherches récentes
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Contacts récents',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('John Doe', style: TextStyle(color: Colors.grey)),
                      SizedBox(height: 6),
                      Text('Raki Devon', style: TextStyle(color: Colors.grey)),
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