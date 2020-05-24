class Note{
  String title;
  DateTime createdAt;


  Note.fromJson(Map<String,dynamic>json){
    title = json['title'];
    createdAt = json['createdAt'];
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> json = <String,dynamic>{};
    json['title'] = title;
    json['createdAt'] = createdAt;
    return json;
  }

}