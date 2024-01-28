import 'dart:io';

import 'package:adorable_star/i18n/i18n_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:adorable_star/router/pages.dart';
import 'package:system_tray/system_tray.dart';
import 'package:window_manager/window_manager.dart';

/// 初始化 & 加载数据
Future<void> init() async {
  await initWindow(); // 窗口
  await initSystemTray(); // 托盘
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
}

/// 窗口相关初始化
Future<void> initWindow() async {
  await windowManager.ensureInitialized();
  windowManager.setTitle("萌媛星");
  windowManager.waitUntilReadyToShow(
    const WindowOptions(
      size: Size(1024, 720),
      minimumSize: Size(480, 720),
      center: true,
      title: "萌媛星",
      titleBarStyle: TitleBarStyle.hidden,
    ),
  );
  windowManager.show();
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
