class Article {
  String id;
  String title;
  String law;
  String? lang;
  int? chapterId;

  Article(this.id, this.title, this.law, {this.lang, this.chapterId});

  Article.fromJson(Map<String, dynamic> json)
      : id = json['id']?.toString() ?? '',
        title = json['title']?.toString() ?? '',
        law = json['law']?.toString() ?? '',
        lang = json['lang']?.toString(),
        chapterId = json['chapter'] is Map<String, dynamic>
            ? json['chapter']['id']
            : null;

  static List<Article> listFromResponse(dynamic payload) {
    if (payload is Map<String, dynamic> && payload['data'] is List) {
      return (payload['data'] as List)
          .map((e) => Article.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }

    if (payload is List) {
      return payload
          .map((e) => Article.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }

    return <Article>[];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'law': law,
      'lang': lang,
      'chapter': chapterId == null ? null : {'id': chapterId},
    };
  }
}
