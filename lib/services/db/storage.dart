import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:adorable_star/utils/utils.dart';
import 'package:adorable_star/constants/constants.dart';
import 'package:adorable_star/services/db/model/course.dart';
import 'package:adorable_star/services/db/model/message.dart';
import 'package:adorable_star/services/db/model/assignment.dart';

class Storage extends GetxService {
  late final Isar isar;

  late final SharedPreferences sp;

  Future<Storage> init() async {
    isar = await Isar.open(
      [MessageSchema, CourseSchema, AssignmentSchema],
      directory: getCwd(),
    );

    sp = await SharedPreferences.getInstance();

    return this;
  }

  Future<void> updateDbWithServerData(Map<String, dynamic> serverResponse) async {
    // 存入 GPA 与 数据检索时间至 Shared Preferences
    sp.setDouble(Keys.GPA, double.parse(serverResponse["data"]["gpa"]));
    sp.setString(Keys.FETCHED_AT, serverResponse["data"]["fetched_at"]);

    // 处理与存储其余科目与作业数据
    List messages = serverResponse["data"]["data"]["messages"] ?? [];
    isar.writeTxn(() => isar.messages.putAll(messages.map((e) => Message.fromJson(e)).toList()));

    List courses = serverResponse["data"]["data"]["courses"] ?? [];
    isar.writeTxn(() => isar.courses.putAll(courses.map((e) => Course.fromJson(e)).toList()));

    List assignments = serverResponse["data"]["data"]["assignments"] ?? [];
    isar.writeTxn(() => isar.assignments.putAll(assignments.map((e) => Assignment.fromJson(e)).toList()));
  }
}
