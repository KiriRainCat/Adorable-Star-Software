import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:system_tray/system_tray.dart';
import 'package:window_manager/window_manager.dart';
import 'package:windows_single_instance/windows_single_instance.dart';

import 'package:adorable_star/router/pages.dart';
import 'package:adorable_star/constants/colors.dart';
import 'package:adorable_star/i18n/i18n_service.dart';
import 'package:adorable_star/services/services.dart';
import 'package:adorable_star/components/components.dart';

/// 初始化 & 加载数据
Future<void> init() async {
  await WindowsSingleInstance.ensureSingleInstance([], "萌媛星"); // 确保单例

  await Get.putAsync(() => Storage().init()); // 存储服务
  await Get.putAsync(() => ApiService().init()); // API 服务
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
  Rx<Size> size = Size(1024, 720).obs;
  RxBool isMaximized = false.obs;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '萌媛星',
      initialRoute: Pages.INITIAL,
      getPages: Pages.routes,
      locale: I18nService.locale,
      fallbackLocale: I18nService.fallBackLocale,
      translations: I18nService(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "SourceHanSansSC", useMaterial3: false),
      defaultTransition: Transition.noTransition,
    );
  }

  Widget buildAppWithWindowControls(Widget application) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColors.SecondaryBg,
        body: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            application,

            // 窗口控制
            Obx(
              () => Positioned(
                width: size.value.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        height: 16,
                        child: GestureDetector(
                          onLongPressDown: (_) => windowManager.startDragging(),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        RoundedButton(
                          width: 24,
                          height: 16,
                          margin: EdgeInsets.all(4),
                          onPressed: () => windowManager.minimize(),
                          child: Icon(CupertinoIcons.minus, size: 16),
                        ),
                        RoundedButton(
                          width: 14,
                          height: 16,
                          margin: EdgeInsets.all(4),
                          onPressed: () => isMaximized.value ? windowManager.unmaximize() : windowManager.maximize(),
                          child: Icon(Icons.square_outlined, size: 14),
                        ),
                        RoundedButton(
                          width: 22,
                          height: 22,
                          margin: EdgeInsets.all(4),
                          onPressed: () => windowManager.close(),
                          child: Icon(Icons.close, size: 20, color: Colors.red),
                        ),
                      ],
                    ),
                    SizedBox(width: 12),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onWindowResize() async {
    super.onWindowResize();
    size.value = await windowManager.getSize();
  }

  @override
  void onWindowMaximize() async {
    super.onWindowResize();
    size.value = await windowManager.getSize();
    isMaximized.value = true;
  }

  @override
  void onWindowUnmaximize() async {
    super.onWindowUnmaximize();
    size.value = await windowManager.getSize();
    isMaximized.value = false;
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
