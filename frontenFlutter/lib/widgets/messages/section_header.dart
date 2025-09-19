import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;
  const SectionHeader({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
      child: Row(
        children: [
          Expanded(child: Text(title,
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold))),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
