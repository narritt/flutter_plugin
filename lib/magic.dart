
import 'dart:async';
import 'dart:ui';

import 'package:flutter/services.dart';

class Magic {
  static const MethodChannel _channel = const MethodChannel('magic');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static showDialog() async {
    await _channel.invokeMethod("showDialog");
  }

  static Future<Color> get color async {
    final color = await _channel.invokeListMethod("generateColor");
    return Color.fromRGBO(color[0], color[1], color[2], 1.0);
  }
  
  static Future<int> parseNumber(int num) async =>
      await _channel.invokeMethod("parseNumber", [num]);
}
