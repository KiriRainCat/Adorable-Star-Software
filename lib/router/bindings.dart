import 'package:get/get.dart';
import 'package:flutter/src/widgets/navigator.dart';

import 'package:adorable_star/router/pages.dart';
import 'package:adorable_star/services/services.dart';
import 'package:adorable_star/constants/constants.dart';
import 'package:adorable_star/pages/auth/login/login_controller.dart';
import 'package:adorable_star/pages/notification/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationController());
  }
}

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    RouteSettings? dest = RouteSettings(name: Routes.Notification);

    final String? token = Get.find<ApiService>().sp.getString(Keys.TOKEN);
    if (token == null || token.isEmpty) {
      dest = null;
    }

    return dest;
  }
}
