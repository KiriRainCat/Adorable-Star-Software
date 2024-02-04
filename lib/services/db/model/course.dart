import 'package:isar/isar.dart';

part 'course.g.dart';

@collection
class Course {
  late Id id;

  late final String title;

  late final String percent_grade;

  late final String letter_grade;

  Course();

  Course.fromJson(Map json) {
    this.id = json["id"];
    this.title = json["title"] ?? "";
    this.percent_grade = json["percent_grade"] ?? "";
    this.letter_grade = json["letter_grade"] ?? "";
  }
}
