import 'dart:convert';
class Chapters {
  String id;
  String text;
  String details;
  String articles_count;


  Chapters(this.id, this.text,this.details, this.articles_count);

  Chapters.fromJson(Map json)
        :id=json['id'],
        text=json['text'],
        details=json['description'] ?? '',
        articles_count=json['articles_count'];
  Map toJson(){
    return{
    'id':id,
    'text':text,
    'description':details,
    'articles_count':articles_count,
    };
  }

}
