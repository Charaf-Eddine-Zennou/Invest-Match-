import 'package:flutter/material.dart';
import '../../debug/main_debug.dart';
import '../../services/fake_user_db.dart';

class SettingsScreen extends StatelessWidget {
  final VoidCallback onLogout;
  const SettingsScreen({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> mainSettings = [
      {'label': 'Informations personnelles', 'icon': Icons.person},
      {'label': 'Confidentialité et Autorisations', 'icon': Icons.lock},
      {'label': 'Notifications & Chat', 'icon': Icons.notifications},
      {'label': 'Données et Stockage', 'icon': Icons.storage},
      {'label': 'Mot de passe et Compte', 'icon': Icons.vpn_key},
    ];

    final List<Map<String, dynamic>> otherSettings = [
      {'label': 'Aide', 'icon': Icons.help},
      {'label': 'Feedback', 'icon': Icons.feedback},
      {
        'label': 'A propos',
        'icon': Icons.info,
        'subtitle': 'Version 1.2',
      },
      {
        'label': 'Inviter un ami',
        'icon': Icons.person_add_alt_1,
        'subtitle': 'Inviter un ami à utiliser Nebula',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Paramètres'),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.settings, color: Colors.blue, size: 28),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Paramètres d’application',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          ...mainSettings.map((item) => _buildTile(context, item)),

          const Divider(height: 32),

          const Text(
            'Autres',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          ...otherSettings.map((item) => _buildTile(context, item)),

          const SizedBox(height: 32),

          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const DebugScreen()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange.shade50,
              foregroundColor: Colors.orange,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text("Debug Tools"),
          ),
          const SizedBox(height: 12),

          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade200,
              foregroundColor: Colors.black,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text("Changer de compte"),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () async {
              await FakeUserService().logout();
              onLogout();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text("Se déconnecter"),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(BuildContext context, Map<String, dynamic> item) {
    return InkWell(
      onTap: () {
        // TODO: Implémenter navig vers la sous-page
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(item['icon'], color: Colors.black54),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['label'],
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  if (item['subtitle'] != null)
                    Text(
                      item['subtitle'],
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
