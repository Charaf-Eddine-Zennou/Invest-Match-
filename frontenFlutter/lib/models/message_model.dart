class Message {
  final String senderName;
  final String content;
  final String time;
  final int unreadCount;
  final String profileImage;

  Message({
    required this.senderName,
    required this.content,
    required this.time,
    required this.unreadCount,
    required this.profileImage,
  });
}