import 'package:flutter/material.dart';
import 'package:flutter_weather/Bean/HomePage/CityWeather.dart';
import 'package:flutter_weather/Bean/Air.dart';
import 'package:flutter_weather/Bean/AirStation.dart';
import 'package:flutter_weather/Bean/City.dart';
import 'package:flutter_weather/Bean/DailyForecast.dart';
import 'package:flutter_weather/Bean/LifeStyle.dart';
import 'package:flutter_weather/Bean/Now.dart';
import 'package:flutter_weather/Bean/UpdateTime.dart';
import 'package:flutter_weather/Widget/HomePage/Card/WeatherCityCard.dart';
import 'package:flutter_weather/Widget/HomePage/Card/WeatherAirCard.dart';
import 'package:flutter_weather/Widget/HomePage/Card/WeatherNowCard.dart';
import 'package:flutter_weather/Widget/HomePage/Card/WeatherUpdateTimeCard.dart';
import 'package:flutter_weather/Widget/HomePage/Card/WeatherLifeStyleCard.dart';
import 'package:flutter_weather/Widget/HomePage/Card/WeatherAirStationCard.dart';
import 'package:flutter_weather/Widget/HomePage/Card/WeatherDailyForecastCard.dart';
import 'package:flutter_weather/Widget/HomePage/Card/WeatherHeaderCard.dart';
import 'package:flutter_weather/Manager/NetworkManager.dart';
import 'package:flutter_weather/Manager/ConfigManager.dart';
import 'package:dio/dio.dart';
import 'package:flutter_weather/Network/Response/WeatherResponse.dart';
import 'package:flutter_weather/Network/Response/AirResponse.dart';
import 'package:flutter_weather/Widget/HomePage/BasePager.dart';
import 'package:flutter_weather/Utils/StringUtils.dart';

class WeatherPager extends BasePager{
  String citySearchKeyword;
  Air air;
  AirStation airStation;
  City city;
  DailyForecast dailyForecast;
  LifeStyle lifeStyle;
  Now now;
  UpdateTime updateTime;
  NetworkManager _networkManager = NetworkManager.getInstance();
  ConfigManager _configManager = ConfigManager.getInstance();


  WeatherPager({this.citySearchKeyword = "shenzhen"});

  @override
  State<StatefulWidget> createState() {
    return _WeatherPagerState();
  }

  @override
  IconData getIcon() {
    return Icons.location_city;
  }

  @override
  String getName() {
    if(city == null || StringUtils.isEmpty(city.location)){
      return this.citySearchKeyword;
    }
    return city.location;
  }

  void requestWeatherData() async {
    Response responseWeather = await _networkManager.getWeather(_configManager.getKey(), this.citySearchKeyword);
    WeatherResponse weatherResponse = WeatherResponse.fromResponse(responseWeather);
    this.city = weatherResponse.city;
    this.updateTime = weatherResponse.updateTime;
    this.now = weatherResponse.now;
    this.dailyForecast = weatherResponse.dailyForecast;
    this.lifeStyle = weatherResponse.lifeStyle;

    Response responseAir = await _networkManager.getAirQuality(_configManager.getKey(), this.citySearchKeyword);
    AirResponse airResponse = AirResponse.fromResponse(responseAir);
    this.city = airResponse.city;
    this.updateTime = airResponse.updateTime;
    this.air = airResponse.air;
    this.airStation = airResponse.airStation;

  }

}

class _WeatherPagerState extends State<WeatherPager> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Colors.purple,
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0
                ),
                child: Column(
                    children: _getContentWidgetList()
                )
              )
            ]
        ),
      )
    );
  }

  Future<Null> _onRefresh() async {
    Response responseWeather = await widget._networkManager.getWeather(widget._configManager.getKey(), widget.citySearchKeyword);
    WeatherResponse weatherResponse = WeatherResponse.fromResponse(responseWeather);
    Response responseAir = await widget._networkManager.getAirQuality(widget._configManager.getKey(), widget.citySearchKeyword);
    AirResponse airResponse = AirResponse.fromResponse(responseAir);
    setState(() {
      widget.city = weatherResponse.city;
      widget.updateTime = weatherResponse.updateTime;
      widget.now = weatherResponse.now;
      widget.dailyForecast = weatherResponse.dailyForecast;
      widget.lifeStyle = weatherResponse.lifeStyle;
      widget.air = airResponse.air;
      widget.airStation = airResponse.airStation;
    });
  }

  List<Widget> _getContentWidgetList(){
    List<Widget> resultList = [];
    resultList.add(WeatherUpdateTimeCard(widget.updateTime));  // 更新时间
    resultList.add(WeatherHeaderCard(widget.city, widget.now));  // 头部
    // 实况天气
    if(widget.now != null){
      resultList.add(WeatherNowCard(widget.now));
    }
    // 天气预报
    if(widget.dailyForecast != null){
      resultList.add(WeatherDailyForecastCard(widget.dailyForecast));
    }
    // 城市
    if(widget.city != null){
      resultList.add(WeatherCityCard(widget.city));
    }
    // 空气质量
    if(widget.air != null){
      resultList.add(WeatherAirCard(widget.air));
    }
    // 生活方式
    if(widget.lifeStyle != null){
      resultList.add(WeatherLifeStyleCard(widget.lifeStyle));
    }
    // 空气监测站信息
    if(widget.airStation != null){
      resultList.add(WeatherAirStationCard(widget.airStation));
    }
    return resultList;
  }

}