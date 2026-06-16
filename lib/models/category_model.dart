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
    lawNo = json['lawNo']?.toString() ?? json['law_no']?.toString();
    description = json['description'];
    lang = json['lang'];
    chaptersCount = json['chaptersCount'];
  }

  static List<Category> listFromResponse(dynamic payload) {
    if (payload is Map<String, dynamic> && payload['data'] is List) {
      return (payload['data'] as List)
          .map((e) => Category.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }

    if (payload is List) {
      return payload
          .map((e) => Category.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }

    return <Category>[];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['law_no'] = lawNo;
    data['description'] = description;
    data['lang'] = lang;
    data['chaptersCount'] = chaptersCount;
    return data;
  }
}
