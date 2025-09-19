import 'package:flutter/material.dart';
import '../../models/conversation.dart';
import 'unread_badge.dart';

class ConversationTile extends StatelessWidget {
  final Conversation conv;
  final VoidCallback? onTap;
  const ConversationTile({super.key, required this.conv, this.onTap});

  @override
  Widget build(BuildContext context) {
    final last = conv.lastMessage;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      leading: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(radius: 24, backgroundImage: NetworkImage(conv.peer.avatarUrl)),
          if (conv.unreadCount > 0)
            Positioned(right: -2, bottom: -2, child: UnreadBadge(count: conv.unreadCount, size: 16)),
        ],
      ),
      title: Text(conv.peer.displayName, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(
        last.text,
        maxLines: 1, overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.grey[700]),
      ),
      trailing: Text(_formatTime(last.sentAt),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
      onTap: onTap,
    );
  }

  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    if (now.difference(dt).inDays >= 1) {
      return "${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}";
    }
    final hh = dt.hour.toString().padLeft(2, '0');
    final mm = dt.minute.toString().padLeft(2, '0');
    return "$hh:$mm";
  }
}
