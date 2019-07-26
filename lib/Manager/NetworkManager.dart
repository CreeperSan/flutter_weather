import 'dart:async';
import 'package:dio/dio.dart';


class NetworkManager{

  // 单例模式

  NetworkManager._();

  static NetworkManager _instance;

  static NetworkManager getInstance() {
    if (_instance == null) {
      _instance = NetworkManager._();
    }
    return _instance;
  }

  // 静态方法

  static const String LANG_CHINESE_SIMPLIFY = "zh-ch";
  static const String LANG_CHINESE_TRADITION = "zh-hk";
  static const String LANG_ENGLISH = "en";
  static const String LANG_GERMANY = "de";
  static const String LANG_SPAIN = "es";
  static const String LANG_FRANCE = "fr";
  static const String LANG_ITALY = "it";
  static const String LANG_JAPANESE = "jp";
  static const String LANG_KOREAN = "kr";
  static const String LANG_RUSSIAN = "ru";
  static const String LANG_INDIA = "in";
  static const String LANG_THAILAND = "th";

  static const String UNIT_METRIC = "m";
  static const String UNIT_ENGLAND = "i";

  static const String MODE_EQUAL = "equal";
  static const String MODE_MATCH = "match";

  static const String GROUP_WORLD = "world";
  static const String GROUP_CHINA = "cn";
  static const String GROUP_SCENIC = "scenic";
  static const String GROUP_OVERSEAS = "overseas";

  // 方法

   getWeather(String key, String location, {
    String language = LANG_CHINESE_SIMPLIFY,
    String unit = UNIT_METRIC
  }) async {
    Response response = await Dio().get("https://free-api.heweather.net/s6/weather/?location=$location&key=$key&lang=$language&unit=$unit");
    return response;
  }

  getAirQuality(String key, String location, {
    String language = LANG_CHINESE_SIMPLIFY,
    String unit = UNIT_METRIC
  }) async {
    Response response = await Dio().get("https://free-api.heweather.net/s6/air?location=$location&key=$key&lang=$language&unit=$unit");
    return response;
  }

  getCity(String key, String location, {
    String mode = MODE_MATCH,
    String group = GROUP_WORLD,
    String number = '10',
    String language = LANG_CHINESE_SIMPLIFY
  }) async {
    Response response = await Dio().get("https://search.heweather.net/find?location=$location&key=$key&mode=$mode&group=$group&number=$number&lang=$language");
    return response;
  }

}

