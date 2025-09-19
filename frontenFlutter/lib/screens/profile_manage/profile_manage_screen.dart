import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:nebula_app/models/user_profile_model.dart';
import 'package:nebula_app/widgets/profile_public/public_profile_header.dart';

class ProfileManageScreen extends StatefulWidget {
  final UserProfile me;
  const ProfileManageScreen({super.key, required this.me});

  @override
  State<ProfileManageScreen> createState() => _ProfileManageScreenState();
}

class _ProfileManageScreenState extends State<ProfileManageScreen> with TickerProviderStateMixin {
  late final TabController _tab = TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    final isCompany = widget.me.profileType.toLowerCase() == 'entreprise';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon profil'),
        bottom: TabBar(
          controller: _tab,
          tabs: const [Tab(text: 'Résumé'), Tab(text: 'Éditer'), Tab(text: 'Uploads')],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: [
          // Résumé = header public
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 8),
                PublicProfileHeader(profile: widget.me),
                const SizedBox(height: 12),
                if (isCompany)
                  ListTile(
                    leading: const Icon(Icons.business_center_outlined),
                    title: const Text('Type: Entreprise'),
                    subtitle: Text(widget.me.companyName ?? '—'),
                  )
                else
                  const ListTile(
                    leading: Icon(Icons.person_outline),
                    title: Text('Type: Utilisateur'),
                  ),
              ],
            ),
          ),

          // Éditer
          _EditForm(me: widget.me),

          // Uploads (entreprise)
          _UploadsTab(isCompany: isCompany),
        ],
      ),
    );
  }
}

class _EditForm extends StatelessWidget {
  final UserProfile me;
  const _EditForm({required this.me});

  @override
  Widget build(BuildContext context) {
    final nameCtl = TextEditingController(text: '${me.firstName} ${me.lastName}'.trim());
    final bioCtl  = TextEditingController(text: me.bio);
    final siteCtl = TextEditingController(text: me.domain ?? '');

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(controller: nameCtl, decoration: const InputDecoration(labelText: 'Nom affiché')),
          const SizedBox(height: 12),
          TextField(controller: bioCtl, maxLines: 4, decoration: const InputDecoration(labelText: 'Bio')),
          const SizedBox(height: 12),
          TextField(controller: siteCtl, decoration: const InputDecoration(labelText: 'Site / domaine')),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: () {
              // TODO: persister via FakeUserService.saveUsers()
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Modifications enregistrées')));
            },
            child: const Text('Enregistrer'),
          ),
        ],
      ),
    );
  }
}

class _UploadsTab extends StatelessWidget {
  final bool isCompany;
  const _UploadsTab({required this.isCompany});

  @override
  Widget build(BuildContext context) {
    if (!isCompany) {
      return const Center(child: Text('Les uploads vidéo sont réservés aux entreprises.'));
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ElevatedButton.icon(
            onPressed: () async {
              final picker = ImagePicker();
              final file = await picker.pickVideo(source: ImageSource.gallery);
              if (file != null && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Vidéo sélectionnée: ${file.name}')),
                );
                // TODO: envoi vers  backend / stockage
              }
            },
            icon: const Icon(Icons.file_upload_outlined),
            label: const Text('Uploader une vidéo'),
          ),
          const SizedBox(height: 12),
          const Text('Ici tu affiches la liste des vidéos de l’entreprise (avec statut, vues, etc.).'),
        ],
      ),
    );
  }
}
