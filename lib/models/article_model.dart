import 'dart:convert';

class Article {
  String id;
  String title;
  String law;

  Article(this.id, this.title, this.law);

  Article.fromJson(Map json)
      : id = json['id'],
        title = json['title'],
        law = json['law'];
  Map toJson() {
    return {'id': id, 'title': title, 'law': law};
  }
}
