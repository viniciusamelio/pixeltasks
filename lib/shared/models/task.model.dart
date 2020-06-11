import 'package:pixeltasks/shared/models/note.model.dart';

class Task {
  String title;
  String description;
  DateTime expiresIn;
  String status;
  List<Note> notes = <Note>[];

  Task({this.title,this.description,this.expiresIn,this.notes,this.status});

  Task.fromJson(Map json) {
    title = json['title'];
    description = json['description'];
    expiresIn = json['expiresIn'];
    status = json['status'];
    if (json['notes'] != null) {
      for (var note in json['notes']) {
        notes.add(Note.fromJson(note));
      }
    }
  }

  Map<dynamic, dynamic> toJson() {
    final Map json = {};
    json['title'] = title;
    json['description'] = description;
    json['expiresIn'] = expiresIn;
    json['status'] = status;
    if (notes != null) {
      final List<Map<dynamic, dynamic>> jsonNotes = <Map<dynamic,dynamic>>[];
      for (var note in notes) {
        jsonNotes.add(note.toJson());
      }
      json['notes'] = jsonNotes;
    }
    return json;
  }
}
