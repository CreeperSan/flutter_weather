import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';

class ConfigManager{

  // 单例模式

  ConfigManager._();

  static ConfigManager _instance;

  static ConfigManager getInstance() {
    if (_instance == null) {
      _instance = ConfigManager._();
//      _instance.init();
    }
    return _instance;
  }

  // 方法
  String _key = '';

  MethodChannel methodChannel;
  
  getPref(String table, String key, String defaultValue) async {
    String result = await methodChannel.invokeMethod("getPref", jsonEncode({
      'table' : table,
      'key' : key,
      'default' : defaultValue
    }));
    return result;
  }

  void setPref(String table, String key, String value) async {
    methodChannel.invokeMethod('setPref', jsonEncode({
      'table' : table,
      'key' : key,
      'value' : value
    }));
  }

  /// 实际内容

  /// 初始化，在使用前要调用，记得await
  void init() async {
    methodChannel = MethodChannel('com.creepersan.flutter_weather/SharedPreferenceChannel');
    _key = await getPref('api', 'key', '');
    print('初始化完成 key:$_key');
  }

  void setKey(String key) async {
    _key = key;
    setPref('api', 'key', key);
  }

  String getKey(){
    return _key;
  }

}
