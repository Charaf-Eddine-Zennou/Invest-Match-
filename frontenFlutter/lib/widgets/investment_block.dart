import 'package:flutter/material.dart';
import '../models/investment_model.dart';

class InteractionsBlock extends StatefulWidget {
  final List<Investment> investments;
  const InteractionsBlock({required this.investments, super.key});

  @override
  State<InteractionsBlock> createState() => _InteractionsBlockState();
}

class _InteractionsBlockState extends State<InteractionsBlock> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final tabIcons = [
      Icons.attach_money,
      Icons.favorite_border,
      Icons.bar_chart,
      Icons.bookmark_border,
    ];

    Widget content;
    switch (selectedTab) {
      case 0:
        content = const Center(child: Text("Mes investissements"));
        /*content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Mes investissements",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...widget.investments.map((inv) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade100,
                ),
                child: Row(
                  children: [
                    Image.asset(inv.logoPath, height: 40),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(inv.companyName,
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text(inv.sector,
                              style: const TextStyle(color: Colors.grey)),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: inv.progress,
                            color: Colors.green,
                            backgroundColor: Colors.grey.shade300,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(inv.amount),
                  ],
                ),
              );
            }).toList(),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text("Vérifier votre identité"),
            ),
          ],
        );*/
        break;
      case 1:
        content = const Center(child: Text("Favoris"));
        break;
      case 2:
        content = const Center(child: Text("Statistiques"));
        break;
      case 3:
        content = const Center(child: Text("Publications"));
        break;
      default:
        content = const SizedBox.shrink();
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(tabIcons.length, (index) {
            return IconButton(
              icon: Icon(
                tabIcons[index],
                size: 28,
                color: selectedTab == index ? Theme.of(context).primaryColor : Colors.grey,
              ),
              onPressed: () => setState(() => selectedTab = index),
            );
          }),
        ),

        // Trait sous les icônes
        const Divider(
          thickness: 1,
          color: Color(0xFFE0E0E0),
          height: 1,
        ),

        const SizedBox(height: 16),
        content,
      ],
    );
  }
}