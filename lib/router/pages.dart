import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:adorable_star/router/bindings.dart';
import 'package:adorable_star/pages/notification/notification_view.dart';

part 'routes.dart';

class Pages {
  static const INITIAL = Routes.Notification;

  static final routes = [
    GetPage(
      name: Routes.Notification,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: Routes.Login,
      page: () => const Text("Login"),
    ),
    GetPage(
      name: Routes.Register,
      page: () => const Text("Register"),
    ),
  ];
}
