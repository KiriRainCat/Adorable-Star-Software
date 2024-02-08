import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:adorable_star/router/pages.dart';
import 'package:adorable_star/constants/constants.dart';
import 'package:adorable_star/components/components.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideBarWrapper extends StatelessWidget {
  const SideBarWrapper({
    super.key,
    required this.content,
  });

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.SecondaryBg,
      body: Row(
        children: [
          Container(
            width: 72,
            height: double.infinity,
            color: AppColors.primaryBg,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 16),
                      Text("萌媛星"),
                      IconButton(
                        onPressed: () =>
                            Get.currentRoute == Routes.Notification ? null : Get.toNamed(Routes.Notification),
                        icon: Icon(
                          Icons.notifications,
                          color: Get.currentRoute == Routes.Notification ? Colors.blue : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                buildLogoutButton(),
                SizedBox(height: 8),
              ],
            ),
          ),
          Expanded(child: content),
        ],
      ),
    );
  }

  RoundedButton buildLogoutButton() {
    return RoundedButton(
      width: 20,
      height: 20,
      margin: EdgeInsets.all(4),
      onPressed: () async {
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString(Keys.TOKEN, "");
        sp.setString(Keys.NAME, "");
        sp.setString(Keys.PASSWORD, "");
        Get.offAllNamed(Routes.Login);
      },
      child: Icon(Icons.logout, size: 20),
    );
  }
}
