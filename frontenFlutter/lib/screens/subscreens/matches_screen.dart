import 'package:flutter/material.dart';
import '../../services/fake_message_db.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mes matchs')),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: .7),
        itemCount: fakeMatches.length,
        itemBuilder: (_, i) {
          final u = fakeMatches[i];
          return Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(u.avatarUrl, fit: BoxFit.cover, width: double.infinity),
                ),
              ),
              const SizedBox(height: 6),
              Text(u.displayName, maxLines: 1, overflow: TextOverflow.ellipsis),
            ],
          );
        },
      ),
    );
  }
}
