import 'package:flutter/foundation.dart';

class PluginLogger {
  const PluginLogger._();

  static const String _pluginPrefix = 'FlutterYandexAdsPlus';

  static void log(Object? object) {
    _printWithPrefix(object?.toString());
  }

  static void _printWithPrefix(String? string) {
    debugPrint('$_pluginPrefix / $string');
  }
}
