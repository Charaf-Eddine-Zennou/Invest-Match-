import 'package:flutter/material.dart';

class BottomSheetPostActions extends StatelessWidget {
  const BottomSheetPostActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey.shade200,
                radius: 25,
                child: Icon(Icons.share, color: Colors.black),
              ),
              SizedBox(height: 4),
              Text("Partager", style: TextStyle(fontSize: 13)),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey.shade200,
                radius: 25,
                child: Icon(Icons.bookmark, color: Colors.black),
              ),
              SizedBox(height: 4),
              Text("Enregistrer", style: TextStyle(fontSize: 13)),
            ],
          ),
        ],
      ),
    );
  }
}


class _RoundAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _RoundAction({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onTap,
          child: Container(
            width: 62, height: 62,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 32),
          ),
        ),
        SizedBox(height: 6),
        Text(label, style: TextStyle(color: Colors.white70, fontSize: 14)),
      ],
    );
  }
}
