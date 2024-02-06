import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:adorable_star/router/pages.dart';
import 'package:adorable_star/services/services.dart';
import 'package:adorable_star/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  // 表单样式相关
  RxBool submitting = false.obs;
  RxBool obscurePassword = true.obs;
  RxList<Color?> inputFieldFillColors = [Colors.grey[200], Colors.grey[200]].obs;
  RxList<double> inputOpacities = [0.65, 0.65].obs;

  // 表单逻辑相关
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxList<TextEditingController> textControllers = [TextEditingController(), TextEditingController()].obs;

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      submitting.value = true;
      bool success = false;
      try {
        success = await Get.find<ApiService>().login(
          name: textControllers[0].text,
          password: textControllers[1].text,
        );
      } catch (_) {}

      submitting.value = false;
      if (success) {
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString(Keys.NAME, textControllers[0].text);
        sp.setString(Keys.PASSWORD, textControllers[1].text);

        Get.find<DataSyncService>().sync();

        Get.offAllNamed(Routes.Notification);
      }
    }
  }
}
