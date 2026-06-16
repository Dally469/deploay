class Chapters {
  int? id;
  String? text;
  String? details;
  String? title;
  String? description;
  int? categoryId;
  String? lang;
  int? articleCount;

  Chapters(
      {this.id,
      this.text,
      this.details,
      this.title,
      this.description,
      this.categoryId,
      this.lang,
      this.articleCount});

  Chapters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text']?.toString();
    details = json['details']?.toString();
    // Backward + forward compatibility between old and new APIs.
    title = json['title']?.toString() ?? text;
    description = json['description']?.toString() ?? details;
    categoryId = json['categoryId'];
    lang = json['lang'];
    articleCount = json['articleCount'] ?? json['articlesCount'];
  }

  static List<Chapters> listFromResponse(dynamic payload) {
    if (payload is Map<String, dynamic> && payload['data'] is List) {
      return (payload['data'] as List)
          .map((e) => Chapters.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }

    if (payload is List) {
      return payload
          .map((e) => Chapters.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }

    return <Chapters>[];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['details'] = details;
    data['title'] = title;
    data['description'] = description;
    data['categoryId'] = categoryId;
    data['lang'] = lang;
    data['articlesCount'] = articleCount;
    return data;
  }
}
