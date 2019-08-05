import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_weather/Bean/City.dart';
import 'package:flutter_weather/Utils/JsonUtils.dart';

class CacheManager{

  // 单例模式

  CacheManager._();

  static CacheManager _instance;

  static CacheManager getInstance() {
    if (_instance == null) {
      _instance = CacheManager._();
    }
    return _instance;
  }

  // 方法

  /// 初始化
  Directory _rootDirectory;
  Directory _cacheDirectory;
  Directory _cacheCityDirectory;

  Directory _dataDirectory;
  File _cityListFile;

  void init() async {
    _rootDirectory = await getApplicationDocumentsDirectory();

    _cacheDirectory = Directory('${_rootDirectory.path}/cache');
    _cacheCityDirectory = Directory('${_cacheDirectory.path}/city');

    _dataDirectory = Directory('${_rootDirectory.path}/data');
    _cityListFile = File('${_dataDirectory.path}/city');
  }

  Future<List<City>> readCity() async {
    List<City> cityList = [];
    bool isExist = await _cityListFile.exists();
    if(isExist){
      String jsonObj = await _cityListFile.readAsString();
      dynamic json = JsonUtils.decode(jsonObj);
      if(json is List){
        for(int i=0; i<json.length ;i++){
          dynamic item = json[i];
          try{
            City city = City.fromResponse(item);
            cityList.add(city);
          }catch(e){
            continue;
          }
        }
      }
    }
    return cityList;
  }

  void writeCity(List<City> cityList) async {
    bool isExist = await _cityListFile.exists();
    if(!isExist){
      await _cityListFile.create(recursive: true);
    }
    await _cityListFile.writeAsString(JsonUtils.encode(cityList));
  }

  void addCity(City city) async {
    List<City> cityList = await readCity();
    cityList.forEach((tmpCity){
      if(tmpCity.cid == city.cid){ // 城市已经添加过了
        return;
      }
    });
    cityList.add(city);
    await writeCity(cityList);
  }

  void writeCityWeatherCache(){

  }

  void readCityWeatherCache(){

  }

}
