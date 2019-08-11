import 'package:flutter_weather/Bean/City.dart';
import 'package:flutter_weather/Bean/CityWeather.dart';
import 'package:flutter_weather/Manager/CacheManager.dart';

// 全局数据
class GlobalData{

  /// 单例模式
  GlobalData._();

  static GlobalData _instance;

  static GlobalData getInstance() {
    if (_instance == null) {
      _instance = GlobalData._();
    }
    return _instance;
  }

  /// 方法
  Map<String, CityWeather> _globalCityMap = {};

  void init() async {
    // 初始化已经添加的城市
    List<City> cityList = await CacheManager.getInstance().readCity();
    cityList.forEach((city){
      CityWeather cityWeather = CityWeather();
      cityWeather.city = city;
      _globalCityMap[city.cid] = cityWeather;
    });
  }

  List<CityWeather> getCityWeatherList(){
    List<CityWeather> cityList = [];
    _globalCityMap.forEach((cid, cityWeather){
      cityList.add(cityWeather);
    });
    return cityList;
  }

  CityWeather getWeatherByCityID(String cid){
    if(_globalCityMap.containsKey(cid)){
      return _globalCityMap[cid];
    }
    return CityWeather();
  }

  void setCityWeatherByCityID(String cid, CityWeather cityWeather){
//    printCache();
    _globalCityMap[cid] = cityWeather;
//    print(cityWeather);
  }

  void removeCityWeatherByCityID(String cid){
    _globalCityMap.removeWhere((String key, CityWeather a){
      return key == cid;
    });
  }

  void printCache(){
    String t = "===========================\n";
    t = t + "缓存大小 -> ${_globalCityMap.length}\n";
    _globalCityMap.keys.forEach((key){
      t = t + "【$key】 ${_globalCityMap[key].toString()}\n";
    });
    t = t + "==============================";
    print(t);
  }

}