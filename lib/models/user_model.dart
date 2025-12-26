class UserModel {
  final String id;
  final String name;
  final bool isOnline;
  final DateTime? lastSeen;

  UserModel({
    required this.id,
    required this.name,
    this.isOnline = false,
    this.lastSeen,
  });

  String get initial => name.isNotEmpty ? name[0].toUpperCase() : '?';
  
  String get statusText {
    if (isOnline) return 'Online';
    if (lastSeen != null) {
      final difference = DateTime.now().difference(lastSeen!);
      if (difference.inMinutes < 1) return 'Just now';
      if (difference.inMinutes < 60) return '${difference.inMinutes} min ago';
      if (difference.inHours < 24) return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    }
    return 'Offline';
  }
}

