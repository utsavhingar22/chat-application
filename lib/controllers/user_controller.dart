import '../models/user_model.dart';

class UserController {
  final List<UserModel> _users = [];
  
  List<UserModel> get users => List.unmodifiable(_users);

  void addUser(String name) {
    if (name.trim().isEmpty) return;
    
    // Randomly assign online status for demo
    final isOnline = DateTime.now().millisecondsSinceEpoch % 3 == 0;
    final lastSeen = isOnline ? null : DateTime.now().subtract(
      Duration(minutes: (DateTime.now().millisecondsSinceEpoch % 120).toInt()),
    );
    
    final user = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name.trim(),
      isOnline: isOnline,
      lastSeen: lastSeen,
    );
    
    _users.add(user);
  }

  UserModel? getUserById(String id) {
    try {
      return _users.firstWhere((user) => user.id == id);
    } catch (e) {
      return null;
    }
  }
}

