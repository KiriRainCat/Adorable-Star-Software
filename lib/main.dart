import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_tray/system_tray.dart';
import 'package:window_manager/window_manager.dart';
import 'package:windows_single_instance/windows_single_instance.dart';

import 'package:adorable_star/router/pages.dart';
import 'package:adorable_star/i18n/i18n_service.dart';
import 'package:adorable_star/services/services.dart';

/// 初始化 & 加载数据
Future<void> init() async {
  await WindowsSingleInstance.ensureSingleInstance([], "萌媛星"); // 确保单例

  (await SharedPreferences.getInstance()).setString("token",
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJBZG9yYWJsZVN0YXJTZXJ2ZXIiLCJleHAiOjE3MDQ3OTAyMjMsIm5iZiI6MTcwNDcwMzc2MywidWlkIjoxLCJzdGF0dXMiOjkwMCwiZW1haWwiOiJzYW0uemhvdUBnZW9yZ2lhc2Nob29sLmNuIn0.0EFpZL5zYVjz_x6UVX_bCahaE9YfCxMJsQeU9jiH-lQ");
  await Get.putAsync(() => Storage().init()); // 存储服务
  await Get.putAsync(() => DataSyncService().init()); // 数据同步服务

  await initWindow(); // 窗口
  await initSystemTray(); // 托盘
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WindowListener {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '萌媛星',
      initialRoute: Pages.INITIAL,
      getPages: Pages.routes,
      home: const Text("Home"),
      locale: I18nService.locale,
      fallbackLocale: I18nService.fallBackLocale,
      translations: I18nService(),
      debugShowCheckedModeBanner: false,
    );
  }

  @override
  void onWindowClose() {
    windowManager.hide();
  }

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowFocus() {
    // Make sure to call once.
    setState(() {});
  }
}

/// 窗口相关初始化
Future<void> initWindow() async {
  await windowManager.ensureInitialized();
  windowManager.setTitle("萌媛星");
  windowManager.setPreventClose(true);
  windowManager.waitUntilReadyToShow(
    const WindowOptions(
      size: Size(1024, 720),
      minimumSize: Size(480, 720),
      center: true,
      title: "萌媛星",
      titleBarStyle: TitleBarStyle.hidden,
    ),
    () async {
      await windowManager.show();
      await windowManager.focus();
    },
  );
}

/// 托盘图标相关初始化
Future<void> initSystemTray() async {
  // 初始化图标与标题
  final SystemTray tray = SystemTray();
  await tray.initSystemTray(
    title: "萌媛星",
    iconPath: Platform.isWindows ? "assets/images/icon.ico" : "assets/images/icon.png",
  );

  // 添加右键菜单
  final Menu trayMenu = Menu();
  await trayMenu.buildFrom([
    MenuItemLabel(label: "退出", onClicked: (p0) => windowManager.destroy()),
  ]);
  tray.setContextMenu(trayMenu);

  // 注册点击事件
  tray.registerSystemTrayEventHandler((eventName) {
    if (eventName == kSystemTrayEventClick) {
      Platform.isWindows ? windowManager.show() : tray.popUpContextMenu();
    } else if (eventName == kSystemTrayEventRightClick) {
      Platform.isWindows ? tray.popUpContextMenu() : windowManager.show();
    }
  });
}
