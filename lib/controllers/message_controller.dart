import 'dart:async';
import '../models/message_model.dart';
import '../models/chat_history_model.dart';
import '../services/api_service.dart';

class MessageController {
  final Map<String, List<MessageModel>> _messages = {};
  final Map<String, ChatHistoryModel> _chatHistory = {};

  List<MessageModel> getMessagesForUser(String userId) {
    return List.unmodifiable(_messages[userId] ?? []);
  }

  ChatHistoryModel? getChatHistory(String userId) {
    return _chatHistory[userId];
  }

  List<ChatHistoryModel> getAllChatHistory() {
    return _chatHistory.values.toList()
      ..sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));
  }

  Future<void> sendMessage(String userId, String userName, String text) async {
    if (text.trim().isEmpty) return;

    final message = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text.trim(),
      type: MessageType.sender,
      timestamp: DateTime.now(),
      userId: userId,
      userName: userName,
    );

    _messages.putIfAbsent(userId, () => []).add(message);
    _updateChatHistory(userId, userName, text, DateTime.now(), 0); // Reset unread when sender sends

    // Fetch and add receiver message after a short delay
    await Future.delayed(const Duration(seconds: 1));
    await _fetchAndAddReceiverMessage(userId, userName);
  }

  Future<void> _fetchAndAddReceiverMessage(String userId, String userName) async {
    final receiverText = await ApiService.fetchRandomMessage();
    
    final message = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: receiverText,
      type: MessageType.receiver,
      timestamp: DateTime.now(),
      userId: userId,
      userName: userName,
    );

    _messages.putIfAbsent(userId, () => []).add(message);
    
    // Increment unread count for receiver messages
    final existing = _chatHistory[userId];
    final unreadCount = existing != null ? existing.unreadCount + 1 : 1;
    
    _updateChatHistory(userId, userName, receiverText, DateTime.now(), unreadCount);
  }

  void _updateChatHistory(String userId, String userName, String lastMessage, DateTime timestamp, [int? unreadCount]) {
    final existing = _chatHistory[userId];
    final count = unreadCount ?? (existing != null ? existing.unreadCount : 0);
    
    _chatHistory[userId] = ChatHistoryModel(
      userId: userId,
      userName: userName,
      lastMessage: lastMessage,
      lastMessageTime: timestamp,
      unreadCount: count,
    );
  }
  
  void markAsRead(String userId) {
    final existing = _chatHistory[userId];
    if (existing != null) {
      _chatHistory[userId] = ChatHistoryModel(
        userId: existing.userId,
        userName: existing.userName,
        lastMessage: existing.lastMessage,
        lastMessageTime: existing.lastMessageTime,
        unreadCount: 0,
      );
    }
  }
  
  void incrementUnreadCount(String userId) {
    final existing = _chatHistory[userId];
    if (existing != null) {
      _chatHistory[userId] = ChatHistoryModel(
        userId: existing.userId,
        userName: existing.userName,
        lastMessage: existing.lastMessage,
        lastMessageTime: existing.lastMessageTime,
        unreadCount: existing.unreadCount + 1,
      );
    }
  }
}

