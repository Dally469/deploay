class Chapters {
  int? id;
  String? title;
  String? description;
  int? categoryId;
  String? lang;
  int? articleCount;

  Chapters(
      {this.id,
      this.title,
      this.description,
      this.categoryId,
      this.lang,
      this.articleCount});

  Chapters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    categoryId = json['categoryId'];
    lang = json['lang'];
    articleCount = json['articleCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['categoryId'] = categoryId;
    data['lang'] = lang;
    data['articleCount'] = articleCount;
    return data;
  }
}
