import 'package:flutter_weather/Bean/Air.dart';
import 'package:flutter_weather/Bean/AirStation.dart';
import 'package:flutter_weather/Bean/City.dart';
import 'package:flutter_weather/Bean/DailyForecast.dart';
import 'package:flutter_weather/Bean/LifeStyle.dart';
import 'package:flutter_weather/Bean/Now.dart';
import 'package:flutter_weather/Bean/UpdateTime.dart';

class CityWeather{
  Air air;
  AirStation airStation;
  City city;
  DailyForecast dailyForecast;
  LifeStyle lifeStyle;
  Now now;
  UpdateTime updateTime;

  CityWeather({
    this.air,
    this.airStation,
    this.city,
    this.dailyForecast,
    this.lifeStyle,
    this.now,
    this.updateTime
  });

  @override
  String toString() {
    return "【${city!=null ? city.cid : "null" }】${city!=null ? city.location : "null" } 更新=${updateTime!=null ? updateTime.localTime : "null" } 温度=${now!=null ? now.tmp : "null" }  天气=${now!=null ? now.condTxt : "null" }";
  }

  String getCid(){
    if(city == null){
      return "【No ID】";
    }
    return city.cid;
  }

}