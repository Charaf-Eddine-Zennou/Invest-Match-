class Message {
  final String id;
  final String conversationId;
  final String senderId;
  final String text;
  final DateTime sentAt;
  final bool read;

  const Message({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.text,
    required this.sentAt,
    required this.read,
  });
}
