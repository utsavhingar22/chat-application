class ChatHistoryModel {
  final String userId;
  final String userName;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;

  ChatHistoryModel({
    required this.userId,
    required this.userName,
    required this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = 0,
  });

  String get userInitial => userName.isNotEmpty ? userName[0].toUpperCase() : '?';
}

