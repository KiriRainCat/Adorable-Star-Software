import 'package:get/get.dart';
import 'package:isar/isar.dart';

import 'package:adorable_star/utils/utils.dart';
import 'package:adorable_star/services/db/model/info.dart';
import 'package:adorable_star/services/db/model/course.dart';
import 'package:adorable_star/services/db/model/message.dart';
import 'package:adorable_star/services/db/model/assignment.dart';

class Storage extends GetxService {
  late final Isar isar;

  RxString fetchedAt = "None".obs;
  RxDouble gpa = 0.0.obs;
  RxList<Message> messages = <Message>[].obs;

  Future<Storage> init() async {
    isar = await Isar.open(
      [DataInfoSchema, MessageSchema, CourseSchema, AssignmentSchema],
      directory: getCwd(),
    );

    fetchedAt.value = (await isar.dataInfos.get(1))?.fetchedAt ?? "None";
    gpa.value = (await isar.dataInfos.get(1))?.gpa ?? 0;
    messages.value = await isar.messages.filter().idGreaterThan(-1).findAll();

    return this;
  }

  Future<void> updateDbWithServerData(Map<String, dynamic> serverResponse) async {
    // 存入 GPA 与 数据检索时间
    isar.writeTxn(
      () => isar.dataInfos.put(
        DataInfo()
          ..fetchedAt = serverResponse["data"]["fetched_at"]
          ..gpa = double.parse(serverResponse["data"]["gpa"]),
      ),
    );

    // 处理与存储其余科目与作业数据
    List messages = serverResponse["data"]["data"]["messages"] ?? [];
    isar.writeTxn(() => isar.messages.putAll(messages.map((e) => Message.fromJson(e)).toList()));

    List courses = serverResponse["data"]["data"]["courses"] ?? [];
    isar.writeTxn(() => isar.courses.putAll(courses.map((e) => Course.fromJson(e)).toList()));

    List assignments = serverResponse["data"]["data"]["assignments"] ?? [];
    isar.writeTxn(() => isar.assignments.putAll(assignments.map((e) => Assignment.fromJson(e)).toList()));

    await refresh();
  }

  Future<void> refresh() async {
    DataInfo info = (await isar.dataInfos.get(1))!;
    fetchedAt.value = info.fetchedAt;
    gpa.value = info.gpa;

    messages.value = await getMessages();
  }

  Future<List<Message>> getMessages() async {
    return await isar.messages.filter().idGreaterThan(-1).findAll();
  }
}
