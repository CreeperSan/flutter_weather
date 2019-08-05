import 'package:flutter/material.dart';
import 'package:flutter_weather/Bean/CityWeather.dart';
import 'package:flutter_weather/Bean/City.dart';
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
import 'package:flutter_weather/Global/GlobalData.dart';

class WeatherPager extends BasePager{
  String citySearchKeyword;
  CityWeather cityWeather;
  NetworkManager _networkManager = NetworkManager.getInstance();
  ConfigManager _configManager = ConfigManager.getInstance();

  WeatherPager.fromCityWeather(CityWeather city){
    this.cityWeather = city;
    if(this.cityWeather == null){
      this.cityWeather = CityWeather();
    }

    state = _WeatherPagerState(cityWeather);
  }

  _WeatherPagerState state ;

  @override
  State<StatefulWidget> createState() {
    return state;
  }

  @override
  IconData getIcon() {
    return Icons.location_city;
  }

  @override
  String getName() {
    if(cityWeather.city == null || StringUtils.isEmpty(cityWeather.city.location)){
      return this.citySearchKeyword;
    }
    return cityWeather.city.location;
  }

}

class _WeatherPagerState extends State<WeatherPager> with AutomaticKeepAliveClientMixin{
  CityWeather cityWeather;

  _WeatherPagerState(this.cityWeather);

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
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
      cityWeather.city = weatherResponse.city;
      cityWeather.updateTime = weatherResponse.updateTime;
      cityWeather.now = weatherResponse.now;
      cityWeather.dailyForecast = weatherResponse.dailyForecast;
      cityWeather.lifeStyle = weatherResponse.lifeStyle;
      cityWeather.air = airResponse.air;
      cityWeather.airStation = airResponse.airStation;
    });
  }

  List<Widget> _getContentWidgetList(){
    List<Widget> resultList = [];
    resultList.add(WeatherUpdateTimeCard(cityWeather.updateTime));  // 更新时间
    resultList.add(WeatherHeaderCard(cityWeather.city, cityWeather.now));  // 头部
    // 实况天气
    if(cityWeather.now != null){
      resultList.add(WeatherNowCard(cityWeather.now));
    }
    // 天气预报
    if(cityWeather.dailyForecast != null){
      resultList.add(WeatherDailyForecastCard(cityWeather.dailyForecast));
    }
    // 城市
    if(cityWeather.city != null){
      resultList.add(WeatherCityCard(cityWeather.city));
    }
    // 空气质量
    if(cityWeather.air != null){
      resultList.add(WeatherAirCard(cityWeather.air));
    }
    // 生活方式
    if(cityWeather.lifeStyle != null){
      resultList.add(WeatherLifeStyleCard(cityWeather.lifeStyle));
    }
    // 空气监测站信息
    if(cityWeather.airStation != null){
      resultList.add(WeatherAirStationCard(cityWeather.airStation));
    }
    print("size -> ${widget}");
    print("size -> ${cityWeather}");
    print("size -> ${cityWeather.city}");
    print("size -> ${cityWeather.now}");
    print("size -> ${resultList.length}");
    return resultList;
  }

}