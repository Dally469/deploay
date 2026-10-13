import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SavedArticle {
  final String id;
  final String title;
  final String law; // HTML content, stored so it can be read offline
  final String chapterTitle;

  const SavedArticle({
    required this.id,
    required this.title,
    required this.law,
    required this.chapterTitle,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'law': law,
        'chapterTitle': chapterTitle,
      };

  factory SavedArticle.fromJson(Map<String, dynamic> j) => SavedArticle(
        id: (j['id'] ?? '').toString(),
        title: (j['title'] ?? '').toString(),
        law: (j['law'] ?? '').toString(),
        chapterTitle: (j['chapterTitle'] ?? '').toString(),
      );
}

class SavedArticlesService {
  static String _key(String lang) => 'saved_articles_$lang';

  static Future<List<SavedArticle>> load(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_key(lang)) ?? [];
    final result = <SavedArticle>[];
    for (final s in raw) {
      try {
        result.add(SavedArticle.fromJson(json.decode(s)));
      } catch (_) {
        // skip corrupted entry
      }
    }
    return result;
  }

  static Future<void> _save(String lang, List<SavedArticle> items) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _key(lang),
      items.map((e) => json.encode(e.toJson())).toList(),
    );
  }

  /// Returns true if the article is now saved, false if it was removed.
  static Future<bool> toggle(String lang, SavedArticle article) async {
    final items = await load(lang);
    final index = items.indexWhere((e) => e.id == article.id);
    if (index >= 0) {
      items.removeAt(index);
      await _save(lang, items);
      return false;
    }
    items.insert(0, article);
    await _save(lang, items);
    return true;
  }

  static Future<void> remove(String lang, String id) async {
    final items = await load(lang);
    items.removeWhere((e) => e.id == id);
    await _save(lang, items);
  }
}