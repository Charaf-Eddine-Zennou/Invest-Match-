import 'package:flutter/material.dart';

class ProfileSectionButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ProfileSectionButton({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: t.colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(blurRadius: 12, color: Color(0x11000000), offset: Offset(0, 4)),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: t.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text(subtitle, style: t.textTheme.bodySmall?.copyWith(color: Colors.black54)),
              ]),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
