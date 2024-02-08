import 'package:get/get.dart';

import 'package:adorable_star/router/bindings.dart';
import 'package:adorable_star/pages/auth/login/login_view.dart';
import 'package:adorable_star/pages/auth/register/register_view.dart';
import 'package:adorable_star/pages/notification/notification_view.dart';

part 'routes.dart';

class Pages {
  static const INITIAL = Routes.Login;

  static final routes = [
    GetPage(
      name: Routes.Notification,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: Routes.Login,
      page: () => const LoginView(),
      binding: LoginBinding(),
      middlewares: [AuthMiddleware()],
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.Register,
      page: () => RegisterView(),
      binding: RegisterBinding(),
      transition: Transition.cupertino,
    ),
  ];
}
