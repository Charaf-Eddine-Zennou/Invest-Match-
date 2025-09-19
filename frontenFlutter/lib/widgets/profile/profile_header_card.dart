import 'package:flutter/material.dart';
import '../../models/user_profile_model.dart';

class ProfileHeaderCard extends StatelessWidget {
  final UserProfile user;
  final double height;
  final VoidCallback? onTap;

  const ProfileHeaderCard({
    super.key,
    required this.user,
    this.height = 210,
    this.onTap,
  });

  bool get _isInvestor => user.profileType.toLowerCase() == 'investisseur';

  String get _displayName {
    final full = '${user.firstName} ${user.lastName}'.trim();
    if ((user.companyName ?? '').trim().isNotEmpty) return user.companyName!;
    if (full.isNotEmpty) return full;
    return user.username;
  }

  ImageProvider? get _avatarProvider {
    final img = user.profileImage;
    if (img.isEmpty) return null;
    if (img.startsWith('http')) return NetworkImage(img);
    return AssetImage(img);
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        height: height,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [t.colorScheme.surface, t.colorScheme.surface.withOpacity(.96)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [BoxShadow(blurRadius: 18, color: Color(0x16000000), offset: Offset(0, 8))],
          border: Border.all(color: t.dividerColor.withOpacity(.2)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 46,
              backgroundImage: _avatarProvider,
              child: _avatarProvider == null ? const Icon(Icons.person, size: 36) : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---- Nom + badge ----
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _displayName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: t.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
                        ),
                      ),
                      if (user.isVerified)
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Icon(Icons.verified, size: 18, color: t.colorScheme.primary),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  if (user.bio.isNotEmpty)
                    Text(
                      user.bio,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: t.textTheme.bodyMedium?.copyWith(color: Colors.black54),
                    ),
                  const Spacer(),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _StatPill(label: "abonnés", value: user.followers),
                      _StatPill(label: "suivis", value: user.following),
                      if (_isInvestor && (user.investorLevel?.isNotEmpty ?? false))
                        _Tag(text: "niveau ${user.investorLevel}"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // ---- Icônes ----
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SocialIcon(icon: Icons.public, onTap: () {}),
                const SizedBox(height: 10),
                _SocialIcon(icon: Icons.link, onTap: () {}),
                const SizedBox(height: 10),
                _SocialIcon(icon: Icons.alternate_email, onTap: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  final String label;
  final int value;
  const _StatPill({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: t.colorScheme.primary.withOpacity(.08),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        "$value $label",
        style: t.textTheme.labelLarge?.copyWith(
          color: t.colorScheme.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String text;
  const _Tag({required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.06),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _SocialIcon({required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      radius: 28,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 22),
      ),
    );
  }
}
