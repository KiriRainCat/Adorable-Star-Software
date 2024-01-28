import 'package:adorable_star/constants/constants.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:adorable_star/pages/notification/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: AppColors.primaryBg,
        ),
        child: Center(
          child: Text(controller.text.string.tr, style: Theme.of(context).textTheme.titleLarge),
        ),
      ),
    );
  }
}
