import 'package:flutter/material.dart';
import '../../models/user_summary.dart';

class RequestAvatar extends StatelessWidget {
  final UserSummary user;
  final bool isNew;
  final VoidCallback? onTap;
  const RequestAvatar({super.key, required this.user, this.isNew = true, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(radius: 28, backgroundImage: NetworkImage(user.avatarUrl)),
              if (isNew)
                Positioned(right: 0, bottom: 0,
                  child: Container(
                    width: 12, height: 12,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      border: Border.all(color: Colors.white, width: 2),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: 64,
            child: Text(user.displayName,
                maxLines: 1, overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
    );
  }
}
