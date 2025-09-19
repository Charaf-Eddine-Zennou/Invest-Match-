import 'package:flutter/material.dart';

class SearchBarFeed extends StatelessWidget {
  const SearchBarFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return

      Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 48,
        child: Row(
          children: const [
            Icon(Icons.search, color: Colors.grey),
            SizedBox(width: 8),
            Text("Rechercher une entreprise", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
