import 'package:adorable_star/services/db/model/message.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:adorable_star/constants/constants.dart';
import 'package:adorable_star/pages/notification/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.SecondaryBg,
      body: Center(
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("notification".tr, style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: 16),
              Text(DateTime.parse(controller.store.fetchedAt.value).toLocal().toString()),
              Text(controller.store.gpa.value.toString()),
              Expanded(
                child: ListView(
                  children: [
                    for (Message msg in controller.store.messages) ...[
                      Card(
                        color: AppColors.primaryBg,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text(msg.created_at.toLocal().toString()),
                              Text(msg.assignment),
                              Text(msg.course),
                              Text(msg.msg),
                            ],
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
