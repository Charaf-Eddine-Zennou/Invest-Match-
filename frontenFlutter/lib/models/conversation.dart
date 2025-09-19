import 'user_summary.dart';
import 'message.dart';

class Conversation {
  final String id;
  final UserSummary peer;
  final Message lastMessage;
  final int unreadCount;

  const Conversation({
    required this.id,
    required this.peer,
    required this.lastMessage,
    this.unreadCount = 0,
  });
}
