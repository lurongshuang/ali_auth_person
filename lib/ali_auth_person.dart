import 'dart:async';

import 'package:flutter/services.dart';

class AliAuthPerson {
  static const MethodChannel _channel = MethodChannel('ali_auth_person');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static const EventChannel _eventChannel =
      EventChannel("ali_auth_person_plugin_event");

  ///认证结果返回监听
  static addListen(Function(String resData) onEvent) {
    _eventChannel.receiveBroadcastStream().listen((data) {
      onEvent(data);
    });
  }

  ///实名认证
  static Future<void> verify(String certifyId) async {
    await _channel.invokeMethod("verify", certifyId);
  }

  ///获取本机参数
  static Future<String> getMetaInfos() async {
    return await _channel.invokeMethod("getMetaInfos");
  }
}
