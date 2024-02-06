import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import 'package:adorable_star/services/services.dart';

class DataSyncService extends GetxService {
  late final Storage store;
  late final ApiService api;
  Timer? scheduledTask;

  Future<DataSyncService> init() async {
    store = Get.find<Storage>();

    api = Get.find<ApiService>();

    sync();

    return this;
  }

  Future<void> sync({int? failed}) async {
    if ((failed ?? 0) > 2) {
      return;
    }

    // 从服务器获取数据
    late Response res;

    // 异常处理
    try {
      res = await api.dio.get("/data/all");
    } catch (_) {
      // 设置下一次数据同步的定时任务，请求失败的情况下 [30分钟]
      scheduledTask = Timer(Duration(minutes: 30), () => sync());
      return;
    }

    // Token 过期处理
    if (res.statusCode == 401 && (failed ?? 0) < 3) {
      sync(failed: (failed ?? 0) + 1);
      return;
    }

    // 存入数据库
    await store.updateDbWithServerData(res.data);

    // 设置下一次数据同步的定时任务 [上次检索时间 + 30分钟 - 当前时间]
    scheduledTask = Timer(
      DateTime.parse(store.fetchedAt.value).add(Duration(minutes: 30)).difference(DateTime.now()),
      () => sync(),
    );
  }
}
