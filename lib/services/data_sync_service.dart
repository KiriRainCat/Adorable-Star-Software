import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import 'package:adorable_star/services/services.dart';
import 'package:adorable_star/constants/constants.dart';

class DataSyncService extends GetxService {
  late final Storage storage;

  late final Dio api;

  late final Timer scheduledTask;

  Future<DataSyncService> init() async {
    storage = Get.find<Storage>();

    api = Dio(BaseOptions(
      baseUrl: "https://adorable-star.kiriraincat.eu.org/api",
      headers: {"Authorization": "dvgZgggolxESd0m"},
    ));

    // 执行一次数据同步
    sync();

    return this;
  }

  Future<void> sync() async {
    // 从服务器获取数据
    Response res = await api.get("/data/all", options: Options(headers: {"Token": storage.sp.getString(Keys.TOKEN)}));

    // 存入数据库
    await storage.updateDbWithServerData(res.data);

    // 设置下一次数据同步的定时任务 [上次检索时间 + 30分钟 - 当前时间]
    scheduledTask = Timer(
      DateTime.parse(storage.sp.getString("fetched_at")!).add(Duration(minutes: 30)).difference(DateTime.now()),
      () => sync(),
    );
  }
}
