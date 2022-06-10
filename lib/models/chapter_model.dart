import 'dart:convert';
class Chapters {
  String id;
  String text;
  String description;
  String articles_count;


  Chapters(this.id, this.text,this.description, this.articles_count);

  Chapters.fromJson(Map json)
        :id=json['id'],
        text=json['text'],
        description=json['description'],
        articles_count=json['articles_count'];
  Map toJson(){
    return{
    'id':id,
    'text':text,
    'description':description,
    'articles_count':articles_count,
    };
  }

}
