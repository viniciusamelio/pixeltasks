class Note{
  String title;
  DateTime createdAt;


  Note.fromJson(Map json){
    title = json['title'];
    createdAt = json['createdAt'];
  }

  Map toJson(){
    final  json = {};
    json['title'] = title;
    json['createdAt'] = createdAt;
    return json;
  }

}