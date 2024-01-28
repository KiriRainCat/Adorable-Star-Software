import 'package:get/get.dart';
import 'package:flutter/widgets.dart';

import 'package:adorable_star/i18n/en_US.dart';
import 'package:adorable_star/i18n/zh_Hans.dart';

class I18nService extends Translations {
  static Locale get locale => Get.deviceLocale ?? fallBackLocale;
  static final fallBackLocale = Locale("zh", "Hans");

  @override
  Map<String, Map<String, String>> get keys => {
        "en_US": en_US,
        "zh_Hans": zh_Hans,
      };
}
