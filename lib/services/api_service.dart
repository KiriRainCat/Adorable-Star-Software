import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:adorable_star/services/db/storage.dart';
import 'package:adorable_star/constants/constants.dart';

class ApiService extends GetxService {
  late final Dio dio;
  late final Storage store;
  late final SharedPreferences sp;

  Future<ApiService> init() async {
    sp = await SharedPreferences.getInstance();

    store = Get.find<Storage>();

    dio = Dio(
      BaseOptions(
        baseUrl: "https://adorable-star.kiriraincat.eu.org/api",
        headers: {
          "Authorization": "dvgZgggolxESd0m",
          "Token": sp.getString(Keys.TOKEN) ?? "",
        },
      ),
    );

    // 响应错误拦截器
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          switch (error.response?.statusCode) {
            case 401:
              await login();
            case 404:
              Get.snackbar("服务器异常", error.toString(), maxWidth: 200, margin: EdgeInsets.only(top: 10));
              break;
            default:
              Get.snackbar("请求异常", error.response?.data["msg"], maxWidth: 200, margin: EdgeInsets.only(top: 10));
          }

          if (error.response != null) {
            handler.resolve(error.response!);
          } else {
            handler.next(error);
          }
        },
      ),
    );

    return this;
  }

  Future<void> clearReqStack() async {}

  Future<bool> login({String? name, String? password}) async {
    name = name ?? sp.getString(Keys.NAME);
    password = password ?? password ?? sp.getString(Keys.PASSWORD);

    if (password == null) {
      return false;
    }

    Response res = await dio.post(
      "/user/login",
      data: {
        "name": name,
        "password": password,
      },
    );

    if (res.statusCode == 200) {
      String token = res.data["data"].toString().split("|")[0];
      sp.setString(Keys.TOKEN, token);
      dio.options.headers["Token"] = token;
      return true;
    }

    return false;
  }
}
