import 'package:dio/src/response.dart';
import 'package:flutter_weather/Network/Response/BaseResponse.dart';
import 'package:flutter_weather/Bean/City.dart';
import 'package:flutter_weather/Bean/UpdateTime.dart';
import 'package:flutter_weather/Bean/Air.dart';
import 'package:flutter_weather/Bean/AirStation.dart';

class AirResponse extends BaseResponse{
  City city;
  UpdateTime updateTime;
  Air air;
  AirStation airStation;

  AirResponse.fromResponse(Response response) : super.fromResponse(response);

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
    // 空气质量
    var airJson = heWeatherJson['air_now_city'];
    if(airJson != null){
      air = Air.fromResponse(airJson);
    }
    // 附件监测站
    var stationJson = heWeatherJson['air_now_station'];
    if(stationJson != null){
      airStation = AirStation.fromResponse(stationJson);
    }

  }

}