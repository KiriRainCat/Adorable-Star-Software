import 'package:isar/isar.dart';

part 'assignment.g.dart';

@collection
class Assignment {
  late Id id;

  late final String from;

  late final DateTime due;

  late final String title;

  late final String score;

  Assignment();

  Assignment.fromJson(Map json) {
    this.id = json["id"];
    this.from = json["from"] ?? "";
    this.due = DateTime.parse(json["due"]);
    this.title = json["title"] ?? "";
    this.score = json["score"] ?? "";
  }
}
