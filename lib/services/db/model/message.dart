import 'package:isar/isar.dart';

part 'message.g.dart';

@collection
class Message {
  late Id id;

  late final int type;

  late final int from;

  late final String course;

  late final String assignment;

  late final String msg;

  late final DateTime created_at;

  Message();

  Message.fromJson(Map json) {
    this.id = json["id"];
    this.type = json["type"] ?? 0;
    this.from = json["from"];
    this.course = json["course"] ?? "";
    this.assignment = json["assignment"] ?? "";
    this.msg = json["msg"] ?? "";
    this.created_at = DateTime.parse(json["created_at"]);
  }
}
