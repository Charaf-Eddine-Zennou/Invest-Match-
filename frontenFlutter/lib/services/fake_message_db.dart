import 'package:intl/intl.dart';
import '../models/user_summary.dart';
import '../models/message.dart';
import '../models/conversation.dart';

final DateFormat _ = DateFormat('yyyy-MM-dd HH:mm');

final fakeMatches = <UserSummary>[
  UserSummary(id: 'u1', displayName: 'Anaïs Dupont', avatarUrl: 'https://i.pravatar.cc/150?img=15'),
  UserSummary(id: 'u2', displayName: 'Liam Rocha',   avatarUrl: 'https://i.pravatar.cc/150?img=55'),
  UserSummary(id: 'u3', displayName: 'Yara Chen',    avatarUrl: 'https://i.pravatar.cc/150?img=32'),
  UserSummary(id: 'u4', displayName: 'Noah Ben',     avatarUrl: 'https://i.pravatar.cc/150?img=8'),
  UserSummary(id: 'u5', displayName: 'Noah Ben',     avatarUrl: 'https://i.pravatar.cc/150?img=8'),
  UserSummary(id: 'u6', displayName: 'Noah Ben',     avatarUrl: 'https://i.pravatar.cc/150?img=8'),
  UserSummary(id: 'u7', displayName: 'Noah Ben',     avatarUrl: 'https://i.pravatar.cc/150?img=8'),
  UserSummary(id: 'u8', displayName: 'Noah Ben',     avatarUrl: 'https://i.pravatar.cc/150?img=8'),
  UserSummary(id: 'u9', displayName: 'Noah Ben',     avatarUrl: 'https://i.pravatar.cc/150?img=8'),
  UserSummary(id: 'u10', displayName: 'Noah Ben',     avatarUrl: 'https://i.pravatar.cc/150?img=8'),
  UserSummary(id: 'u11', displayName: 'Noah Ben',     avatarUrl: 'https://i.pravatar.cc/150?img=8'),
];

final fakeRequests = <UserSummary>[
  UserSummary(id: 'r1', displayName: 'Maya',  avatarUrl: 'https://i.pravatar.cc/150?img=40'),
  UserSummary(id: 'r2', displayName: 'Evan',  avatarUrl: 'https://i.pravatar.cc/150?img=21'),
  UserSummary(id: 'r3', displayName: 'Sofia', avatarUrl: 'https://i.pravatar.cc/150?img=30'),
  UserSummary(id: 'r4', displayName: 'Theo',  avatarUrl: 'https://i.pravatar.cc/150?img=27'),
  UserSummary(id: 'r5', displayName: 'Lea',   avatarUrl: 'https://i.pravatar.cc/150?img=12'),
  UserSummary(id: 'u6', displayName: 'Noah', avatarUrl: 'https://i.pravatar.cc/150?img=8'),
  UserSummary(id: 'u7', displayName: 'Noah', avatarUrl: 'https://i.pravatar.cc/150?img=8'),
  UserSummary(id: 'u8', displayName: 'Noah', avatarUrl: 'https://i.pravatar.cc/150?img=8'),
  UserSummary(id: 'u9', displayName: 'Noah', avatarUrl: 'https://i.pravatar.cc/150?img=8'),
  UserSummary(id: 'u10', displayName: 'Noah', avatarUrl: 'https://i.pravatar.cc/150?img=8'),
  UserSummary(id: 'u11', displayName: 'Noah', avatarUrl: 'https://i.pravatar.cc/150?img=8'),
];

final fakeConversations = <Conversation>[
  Conversation(
    id: 'c1',
    peer: UserSummary(id: 'u10', displayName: 'Amine K.', avatarUrl: 'https://i.pravatar.cc/150?img=10'),
    lastMessage: Message(
      id: 'm1', conversationId: 'c1', senderId: 'u10',
      text: 'Top pour demain 9h, j’envoie le deck.',
      sentAt: DateTime.now().subtract(const Duration(minutes: 12)),
      read: false,
    ),
    unreadCount: 2,
  ),
  Conversation(
    id: 'c2',
    peer: UserSummary(id: 'u11', displayName: 'Chloé V.', avatarUrl: 'https://i.pravatar.cc/150?img=11'),
    lastMessage: Message(
      id: 'm2', conversationId: 'c2', senderId: 'me',
      text: 'Ok, je te partage la maquette Figma.',
      sentAt: DateTime.now().subtract(const Duration(hours: 3)),
      read: true,
    ),
    unreadCount: 0,
  ),
  Conversation(
    id: 'c3',
    peer: UserSummary(id: 'u12', displayName: 'Lucas P.', avatarUrl: 'https://i.pravatar.cc/150?img=12'),
    lastMessage: Message(
      id: 'm3', conversationId: 'c3', senderId: 'u12',
      text: 'On peut call à 18h ?',
      sentAt: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      read: false,
    ),
    unreadCount: 1,
  ),
];
