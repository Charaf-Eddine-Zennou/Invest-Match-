import 'dart:io';

import 'package:flutter/material.dart';
import '../services/fake_user_db.dart';
import 'user_data_screen.dart';
import 'show_all_db_screen.dart';
import 'package:file_picker/file_picker.dart';

class DebugScreen extends StatelessWidget {
  const DebugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Debug / Dev Tools")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ElevatedButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const UserDataScreen())),
            child: const Text("Voir les données de l'utilisateur actuel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const ShowAllDBScreen())),
            child: const Text("Afficher tout le JSON de la DB"),
          ),
          ElevatedButton(
            onPressed: () async {
              await FakeUserService().resetDB();
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("DB réinitialisée !")));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text("Reset DB"),
          ),
          ElevatedButton(
            onPressed: () async {
              // Exporte la base utilisateurs
              final file = await FakeUserService().exportDB();
              if (file == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Aucune DB à exporter.")),
                );
                return;
              }

              final content = await file.readAsBytes();

              String? savedPath = await FilePicker.platform.saveFile(
                dialogTitle: 'Exporter la base utilisateurs',
                fileName: 'users.json',
                bytes: content,
              );

              if (savedPath != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Exporté: $savedPath")),
                );
              }
            },
            child: const Text("Exporter DB (JSON)"),
          ),
          ElevatedButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['json'],
              );
              if (result != null && result.files.single.path != null) {
                final file = File(result.files.single.path!);
                try {
                  await FakeUserService().importDB(file);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Import réussi !")),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Erreur import : $e")),
                  );
                }
              }
            },
            child: const Text("Importer DB depuis JSON"),
          )
        ],
      ),
    );
  }
}
