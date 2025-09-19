import 'package:flutter/material.dart';

class SearchIconButton extends StatelessWidget {
  final Widget targetScreen;

  const SearchIconButton({super.key, required this.targetScreen});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.search, size: 34),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => targetScreen),
        );
      },
    );
  }
}
