import 'package:flutter/material.dart';
import 'package:nebula_app/models/message_model.dart';

class ChatItem extends StatelessWidget {
  final Message message;

  const ChatItem({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // TODO: ouvrir la conversation
          },
          highlightColor: Colors.deepPurple.withOpacity(0.05),
          splashColor: Colors.deepPurple.withOpacity(0.1),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(message.profileImage),
              ),
              title: Text(message.senderName, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                message.content,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(message.time, style: const TextStyle(fontSize: 12)),
                  const SizedBox(height: 4),
                  if (message.unreadCount > 0)
                    Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Colors.deepPurple,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        message.unreadCount.toString(),
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }
}
