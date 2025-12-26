enum MessageType { sender, receiver }

class MessageModel {
  final String id;
  final String text;
  final MessageType type;
  final DateTime timestamp;
  final String userId;
  final String userName;

  MessageModel({
    required this.id,
    required this.text,
    required this.type,
    required this.timestamp,
    required this.userId,
    required this.userName,
  });

  String get userInitial => userName.isNotEmpty ? userName[0].toUpperCase() : '?';
}

