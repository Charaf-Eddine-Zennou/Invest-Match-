import 'package:flutter/material.dart';
import 'package:nebula_app/models/user_profile_model.dart';

class PublicProfileHeader extends StatelessWidget {
  final UserProfile profile;
  const PublicProfileHeader({super.key, required this.profile});

  bool get isCompany => profile.profileType.toLowerCase() == 'entreprise';

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6D28D9), Color(0xFF2563EB), Color(0xFFF43F5E)],
          stops: [0.0, 0.55, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(18)),
      ),
      child: Column(
        children: [
          // ligne titre + icônes
          Row(
            children: [
              Expanded(
                child: Text(
                  isCompany ? (profile.companyName ?? profile.username) : '@${profile.username}',
                  style: t.textTheme.titleLarge?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w800),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.share_outlined, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 8),
          // avatar + follow bar
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 34,
                backgroundImage: (profile.profileImage.isNotEmpty
                    ? (profile.profileImage.startsWith('http')
                    ? NetworkImage(profile.profileImage)
                    : AssetImage(profile.profileImage) as ImageProvider)
                    : null),
                child: profile.profileImage.isEmpty ? const Icon(Icons.person, color: Colors.white) : null,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Wrap(spacing: 16, runSpacing: 8, alignment: WrapAlignment.spaceBetween, children: [
                  _Stat(value: profile.following, label: 'Following'),
                  _Stat(value: profile.followers, label: 'Followers'),
                  _Stat(value:  (profile.followers*18), label: 'Likes'), // fake
                ]),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // bio & link
          if (profile.bio.isNotEmpty)
            Align(
              alignment: Alignment.centerLeft,
              child: Text(profile.bio, style: const TextStyle(color: Colors.white), maxLines: 2, overflow: TextOverflow.ellipsis),
            ),
          if ((profile.domain ?? '').isNotEmpty) ...[
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {},
                child: Text(
                  profile.domain!,
                  style: const TextStyle(color: Colors.white, decoration: TextDecoration.underline),
                ),
              ),
            ),
          ],
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final int value; final String label;
  const _Stat({required this.value, required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_abbr(value), style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800)),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}

String _abbr(int v) {
  if (v >= 1000000) return '${(v / 1000000).toStringAsFixed(1)}M';
  if (v >= 1000) return '${(v / 1000).toStringAsFixed(1)}K';
  return v.toString();
}
