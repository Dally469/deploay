import 'package:shared_preferences/shared_preferences.dart';

class BookmarkService {
  static const _prefix = 'bookmarks_';

  static Future<Set<String>> load(String type) async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList('$_prefix$type') ?? []).toSet();
  }

  /// Returns true if the item is now bookmarked, false if it was removed.
  static Future<bool> toggle(String type, String id) async {
    final prefs = await SharedPreferences.getInstance();
    final set = (prefs.getStringList('$_prefix$type') ?? []).toSet();
    final added = set.add(id);
    if (!added) set.remove(id);
    await prefs.setStringList('$_prefix$type', set.toList());
    return added;
  }
}