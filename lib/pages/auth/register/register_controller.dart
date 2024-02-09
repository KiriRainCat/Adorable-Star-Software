import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:adorable_star/router/pages.dart';
import 'package:adorable_star/services/services.dart';

class RegisterController extends GetxController {
  late ApiService api;

  @override
  void onInit() async {
    api = await Get.find<ApiService>();

    try {
      codeCoolDown.value = DateTime.parse(Get.arguments["coolDownEndsAt"]).difference(DateTime.now()).inSeconds;
    } catch (_) {}

    Timer.periodic(Duration(seconds: 1), (timer) {
      if (codeCoolDown.value < 1) {
        timer.cancel();
        codeCoolDown.value = 0;
        return;
      }
      codeCoolDown.value--;
    });

    super.onInit();
  }

  // 表单样式相关
  RxBool submitting = false.obs;
  RxInt codeCoolDown = 0.obs;
  RxBool obscurePassword = true.obs;
  RxList<Color?> inputFieldFillColors = List.filled(5, Colors.grey[200]).obs;
  RxList<double> inputOpacities = List.filled(5, 0.65).obs;
  RxBool isValidationCodeValid = true.obs;

  // 表单逻辑相关
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxList<GlobalKey<FormFieldState>> fieldKeys = List.generate(5, (_) => GlobalKey<FormFieldState>()).obs;
  RxList<TextEditingController> textControllers = List.generate(5, (_) => TextEditingController()).obs;

  Future<void> sendValidationCode() async {
    // 验证码倒计时
    codeCoolDown.value = 180;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (codeCoolDown.value < 1) {
        timer.cancel();
        codeCoolDown.value = 0;
        return;
      }
      codeCoolDown.value--;
    });

    if (fieldKeys[0].currentState!.validate()) {
      try {
        await api.sendValidationCode(textControllers[0].text);
      } catch (_) {
        codeCoolDown.value = 0;
      }
    } else {
      codeCoolDown.value = 0;
    }
  }

  Future<void> register() async {
    if (formKey.currentState!.validate()) {
      submitting.value = true;
      bool success = false;
      try {
        success = await api.register(
          textControllers[0].text,
          textControllers[1].text,
          textControllers[2].text,
          textControllers[4].text,
        );
      } catch (_) {}

      submitting.value = false;
      if (success) {
        Get.offAllNamed(Routes.Login);
      }
    }
  }
}
