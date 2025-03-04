// ignore_for_file: non_constant_identifier_names

class Category {
  int? id;
  String? title;
  String? lawNo;
  String? description;
  String? lang;
  int? chaptersCount; // ADD THIS

  Category(
      {this.id,
      this.title,
      this.lawNo,
      this.description,
      this.lang,
      this.chaptersCount});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    lawNo = json['lawNo'];
    description = json['description'];
    lang = json['lang'];
    chaptersCount = json['chaptersCount']; // ADD THIS
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['lawNo'] = lawNo;
    data['description'] = description;
    data['lang'] = lang;
    data['chaptersCount'] = chaptersCount; // ADD THIS
    return data;
  }
}
