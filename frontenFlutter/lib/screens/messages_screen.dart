import 'package:flutter/material.dart';
import '../services/fake_message_db.dart';
import '../widgets/messages/match_header_button.dart';
import '../widgets/messages/request_list.dart';
import '../widgets/messages/section_header.dart';
import '../widgets/messages/conversation_tile.dart';
import '../models/conversation.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  int get totalUnread => fakeConversations.fold(0, (s, c) => s + c.unreadCount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MatchHeaderButton(
              onTap: () {
                Navigator.of(context).pushNamed('/matches');
              },
              newCount: 2,
            ),

            const SectionHeader(title: "Demandes"),
            RequestList(
              requests: fakeRequests,
              onTap: (user) {
                // Ouvrir demande
              },
            ),

            SectionHeader(
              title: "Messagerie",
              trailing: IconButton(
                onPressed: () {
                  // Nouvelle conv
                },
                icon: const Icon(Icons.add_circle_outline),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: fakeConversations.length,
                itemBuilder: (context, i) {
                  final Conversation c = fakeConversations[i];
                  return ConversationTile(
                    conv: c,
                    onTap: () {
                      // open chat screen
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
