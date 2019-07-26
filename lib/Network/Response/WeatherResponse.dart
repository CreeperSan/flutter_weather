import 'dart:convert';
import 'package:dio/src/response.dart';
import 'package:flutter_weather/Network/Response/BaseResponse.dart';
import 'package:flutter_weather/Bean/City.dart';
import 'package:flutter_weather/Bean/UpdateTime.dart';
import 'package:flutter_weather/Bean/Now.dart';
import 'package:flutter_weather/Bean/DailyForecast.dart';
import 'package:flutter_weather/Bean/LifeStyle.dart';

class WeatherResponse extends BaseResponse{
  City city;
  UpdateTime updateTime;
  Now now;
  DailyForecast dailyForecast;
  LifeStyle lifeStyle;

  WeatherResponse.fromResponse(Response response) : super.fromResponse(response);

  @override
  parse() {
    var json = this.response.data;
    var heWeatherJsonArray = json['HeWeather6'];
    var heWeatherJson = heWeatherJsonArray[0];
    // 城市
    var cityJson = heWeatherJson['basic'];
    if(cityJson != null){
      city = City.fromResponse(cityJson);
    }
    // 更新时间
    var updateJson = heWeatherJson['update'];
    if(updateJson != null){
      updateTime = UpdateTime.fromResponse(updateJson);
    }
    // 实况天气
    var nowJson = heWeatherJson['now'];
    if(nowJson != null){
      now = Now.fromResponse(nowJson);
    }
    // 天气预告
    var dailyForecastJson = heWeatherJson['daily_forecast'];
    if(dailyForecastJson != null){
      dailyForecast = DailyForecast.fromResponse(dailyForecastJson);
    }
    // 生活方式
    var lifeStyleJson = heWeatherJson['lifestyle'];
    if(lifeStyleJson != null){
      lifeStyle = LifeStyle.fromResponse(lifeStyleJson);
    }
  }

  @override
  String toString() {
    return super.toString();
  }


}