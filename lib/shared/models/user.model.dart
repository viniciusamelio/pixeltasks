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
          boards.add(Board.fromJson(board));
        }
      }
    }
  }

  Map toJson() {
    final Map<dynamic, dynamic> json = <dynamic, dynamic>{};
    json['id'] = id;
    json['name'] = name;
    json['password'] = password;
    if (boards != null) {
      List<Map<dynamic, dynamic>> boardsJson = <Map<dynamic, dynamic>>[];
      for (var board in boards) {
        boardsJson.add(board.toJson());
      }
      json['boards'] = boardsJson;
    }
    return json;
  }
}
