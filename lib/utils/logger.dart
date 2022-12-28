import 'package:flutter/foundation.dart';

class Logger {
  const Logger._();

  static const String _pluginPrefix = 'FlutterYandexAdsPlus';

  static void log(Object? object) {
    _printWithPrefix(object?.toString());
  }

  static void _printWithPrefix(String? string) {
    debugPrint('$_pluginPrefix / $string');
  }
}
