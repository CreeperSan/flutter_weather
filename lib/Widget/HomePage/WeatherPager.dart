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
  NetworkManager _networkManager = NetworkManager.getInstance();
  ConfigManager _configManager = ConfigManager.getInstance();
  final String cid;

  WeatherPager.fromCityID(this.cid);

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
    try{
      return GlobalData.getInstance().getWeatherByCityID(cid).city.location;
    }catch(e){
      return cid;
    }
  }

}

class _WeatherPagerState extends State<WeatherPager> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    CityWeather cityWeather;
    if(widget.cid.isNotEmpty){
      cityWeather = GlobalData.getInstance().getWeatherByCityID(widget.cid);
    }else{
      cityWeather = CityWeather();
    }
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
    Response responseWeather = await widget._networkManager.getWeather(widget._configManager.getKey(), widget.cid);
    WeatherResponse weatherResponse = WeatherResponse.fromResponse(responseWeather);
    Response responseAir = await widget._networkManager.getAirQuality(widget._configManager.getKey(), widget.cid);
    AirResponse airResponse = AirResponse.fromResponse(responseAir);
    GlobalData globalData = GlobalData.getInstance();
    CityWeather cityWeather = globalData.getWeatherByCityID(widget.cid);
    cityWeather.city = weatherResponse.city;
    cityWeather.updateTime = weatherResponse.updateTime;
    cityWeather.now = weatherResponse.now;
    cityWeather.dailyForecast = weatherResponse.dailyForecast;
    cityWeather.lifeStyle = weatherResponse.lifeStyle;
    cityWeather.air = airResponse.air;
    cityWeather.airStation = airResponse.airStation;
    globalData.setCityWeatherByCityID(widget.cid, cityWeather);
    setState(() {
      widget.cid;
    });
  }

  List<Widget> _getContentWidgetList(){
    List<Widget> resultList = [];
    CityWeather cityWeather = GlobalData.getInstance().getWeatherByCityID(widget.cid);
    print('---------------');
    print(widget);
    print(widget.cid);
    print(cityWeather);
    print("cityWeather更新 ${cityWeather.toString()}");
    print('---------------');
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
    return resultList;
  }

}