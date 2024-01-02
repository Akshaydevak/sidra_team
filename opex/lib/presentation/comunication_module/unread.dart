// unread_messages_manager.dart

import 'package:shared_preferences/shared_preferences.dart';

class UnreadMessagesManager {
  static const _unreadKeyPrefix = 'unread_messages_count_';

  static Future<int> getUnreadMessageCount(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_unreadKey(userId)) ?? 0;
  }

  static Future<void> incrementUnreadMessageCount(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentCount = await getUnreadMessageCount(userId);
    await prefs.setInt(_unreadKey(userId), currentCount + 1);
  }

  static Future<void> resetUnreadMessageCount(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_unreadKey(userId), 0);
  }

static String _unreadKey(String userId) {
    return '$_unreadKeyPrefix$userId';
  }
}
