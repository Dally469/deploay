import 'dart:convert';

class Category {
  String id;
  String title;
  String law_no;
  String description;
  String chapters_count;

  Category(this.id, this.title,this.law_no,this.description, this.chapters_count);

  Category.fromJson(Map json)
      : id = json['id'],
        title = json['title'],
        law_no = json['law_no'],
        description = json['description'],
        chapters_count = json['chapters_count'];
  Map toJson() {
    return {
      'id': id,
      'title': title,
      'law_no': law_no,
      'description': description,
      'chapters_count': chapters_count,
    };
  }
}
