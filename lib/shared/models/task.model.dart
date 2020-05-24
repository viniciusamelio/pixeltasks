import 'package:pixeltasks/shared/models/note.model.dart';

class Task {
  String title;
  String description;
  DateTime expiresIn;
  String status;
  List<Note> notes;

  Task.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String,dynamic>{};
    json['title'] = title;
    json['description'] = description;
    json['expiresIn'] = expiresIn;
    json['status'] = status;
    if (notes != null) {
      final List<Map<String, dynamic>> jsonNotes = <Map<String,dynamic>>[];
      for (var note in notes) {
        jsonNotes.add(note.toJson());
      }
      json['notes'] = jsonNotes;
    }
    return json;
  }
}
