import 'package:flutter/material.dart';

class ProfileActionBar extends StatelessWidget {
  final bool isFollowing;
  final VoidCallback onToggleFollow;
  final VoidCallback onMessage;
  final VoidCallback onMore;

  const ProfileActionBar({
    super.key,
    required this.isFollowing,
    required this.onToggleFollow,
    required this.onMessage,
    required this.onMore,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: onToggleFollow,
              child: Text(isFollowing ? 'Suivi' : 'Suivre'),
            ),
          ),
          const SizedBox(width: 10),
          OutlinedButton(
            onPressed: onMessage,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Icon(Icons.mail_outline),
          ),
          const SizedBox(width: 10),
          OutlinedButton(
            onPressed: onMore,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Icon(Icons.more_horiz),
          ),
        ],
      ),
    );
  }
}
