import 'package:flutter/material.dart';

class CompanyProgressBar extends StatelessWidget {
  final double progress; // ex: 0.75
  final String amount;   // ex: "€250k"

  const CompanyProgressBar({
    super.key,
    required this.progress,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Barre
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 20,
              backgroundColor: Colors.grey.shade300,
              color: Colors.green,
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Montant récolté
        Text(
          amount,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
