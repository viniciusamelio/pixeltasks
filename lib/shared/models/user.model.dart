import 'package:pixeltasks/shared/models/board.model.dart';

class User {
  String id;
  String name;
  String password;
  List<Board> boards = <Board>[];

  User({this.id, this.name, this.password, this.boards});

  User.fromJson(Map<dynamic, dynamic> json) {
    if (json != null) {
      id = json['id'];
      name = json['name'];
      password = json['password'];
      if (json['boards'] != null) {
        for (var board in json['boards']) {
          Board.fromJson(board);
        }
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['name'] = name;
    json['password'] = password;
    if (boards != null) {
      List<Map<String, dynamic>> boardsJson = <Map<String, dynamic>>[];
      for (var board in boards) {
        boardsJson.add(board.toJson());
      }
      json['boards'] = boardsJson;
    }
    return json;
  }
}
