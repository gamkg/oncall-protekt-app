enum ConversationStatus { active, closed }

class SupportConversation {
  final String id;
  final String title;
  final String lastMessage;
  final DateTime lastMessageAt;
  final String agentName;
  final int unreadCount;
  final ConversationStatus status;

  const SupportConversation({
    required this.id,
    required this.title,
    required this.lastMessage,
    required this.lastMessageAt,
    required this.agentName,
    required this.unreadCount,
    required this.status,
  });

  factory SupportConversation.fromJson(Map<String, dynamic> json) {
    return SupportConversation(
      id: json['id'] as String,
      title: json['title'] as String,
      lastMessage: json['lastMessage'] as String,
      lastMessageAt: DateTime.parse(json['lastMessageAt'] as String),
      agentName: json['agentName'] as String,
      unreadCount: json['unreadCount'] as int,
      status: ConversationStatus.values.byName(json['status'] as String),
    );
  }

  bool get hasUnread => unreadCount > 0;
}
