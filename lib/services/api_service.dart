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
        onResponse: (response, handler) {
          if (response.headers["New-Token"] != null) {
            final String token = response.headers["New-Token"]![0];
            sp.setString(Keys.TOKEN, token);
            dio.options.headers["Token"] = token;
          }
          handler.next(response);
        },
        onError: (error, handler) async {
          switch (error.response?.statusCode) {
            case 401:
              await login();
              handler.resolve(error.response!);
              return;
            default:
              String err = "网络或未知异常: ${error.message}";
              if (error.response != null) {
                try {
                  err = error.response!.data["msg"];
                } catch (_) {
                  err = error.response!.data;
                }
              }
              Get.snackbar("请求异常", err, maxWidth: 300, margin: EdgeInsets.only(top: 10));
          }
          handler.next(error);
        },
      ),
    );

    return this;
  }

  Future<void> clearReqStack() async {}

  Future<bool> login({String? name, String? password}) async {
    name = name ?? sp.getString(Keys.NAME);
    password = password ?? password ?? sp.getString(Keys.PASSWORD);

    if (name == null || password == null) {
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

  Future<bool> sendValidationCode(String email) async {
    Response res = await dio.post("/user/validation-code/${email}");

    if (res.statusCode == 200) {
      Get.snackbar("验证码已发送", "请查收邮件 (5分钟内有效)", maxWidth: 300, margin: EdgeInsets.only(top: 10));
      return true;
    }

    return false;
  }

  Future<bool> register(String email, String username, String validationCode, String password) async {
    Response res = await dio.post(
      "/user/register",
      data: {
        "email": email,
        "validation_code": validationCode,
        "username": username,
        "password": password,
      },
    );

    if (res.statusCode == 200) {
      Get.snackbar("注册成功", "请登录", maxWidth: 300, margin: EdgeInsets.only(top: 10));
      return true;
    }

    return false;
  }
}
