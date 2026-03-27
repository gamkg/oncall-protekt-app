enum NotificationType { urgent, warning, success, info }

class AppNotification {
  final String id;
  final String title;
  final String body;
  final DateTime timestamp;
  final NotificationType type;
  final bool isRead;
  final bool hasActions;

  const AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    required this.type,
    required this.isRead,
    required this.hasActions,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      type: NotificationType.values.byName(json['type'] as String),
      isRead: json['isRead'] as bool,
      hasActions: json['hasActions'] as bool? ?? false,
    );
  }

  AppNotification copyWith({bool? isRead}) {
    return AppNotification(
      id: id,
      title: title,
      body: body,
      timestamp: timestamp,
      type: type,
      isRead: isRead ?? this.isRead,
      hasActions: hasActions,
    );
  }
}
