import 'package:flutter/material.dart';

class StatPill extends StatelessWidget {
  final String label; final int value;
  const StatPill({super.key, required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: t.colorScheme.primary.withOpacity(.08),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text("$value $label",
        style: t.textTheme.labelLarge?.copyWith(
            color: t.colorScheme.primary, fontWeight: FontWeight.w700),
      ),
    );
  }
}
