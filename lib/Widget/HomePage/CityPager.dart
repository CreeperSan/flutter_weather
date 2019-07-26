import 'package:flutter/material.dart';
import 'package:flutter_weather/Bean/HomePage/CityWeather.dart';
import 'package:flutter_weather/Widget/HomePage/Card/CityCityCard.dart';
import 'package:flutter_weather/Bean/City.dart';
import 'package:flutter_weather/Widget/HomePage/BasePager.dart';
import 'package:flutter_weather/Widget/HomePage/WeatherPager.dart';

class CityPager extends BasePager{

  List<BasePager> _cityWeatherList;

  CityPager([this._cityWeatherList]){
    if(this._cityWeatherList == null){
      this._cityWeatherList = [];
    }
  }


  @override
  String getName() {
    return "城市列表";
  }

  @override
  IconData getIcon() {
    return Icons.home;
  }

  @override
  State<StatefulWidget> createState() {
    return CityPagerState();
  }

}

class CityPagerState extends State<CityPager>  with AutomaticKeepAliveClientMixin{
  List<WeatherPager> _tmpWeatherPagerList = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _initWeatherPagerList();
    return ListView(
      children: _getCityCardList(),
    );
  }

  void _initWeatherPagerList(){
    if(_tmpWeatherPagerList == null){
      _tmpWeatherPagerList = [];
    }else{
      _tmpWeatherPagerList.clear();
    }
    for(BasePager item in widget._cityWeatherList){
      if(item is WeatherPager){
        _tmpWeatherPagerList.add(item);
      }
    }
  }

  List<Widget> _getCityCardList(){
    List<Widget> resultList = [];
    // 城市 卡片
    for(WeatherPager weatherPager in _tmpWeatherPagerList){
      resultList.add(CityCityCard(
          weatherPager.city,
          weatherPager.citySearchKeyword,
          onTap: () => {
            print("city")
          }
      ));
    }
    // 添加城市 卡片
    resultList.add(CityCityCard.addCityCard(
        onTap: () => {
          print("addCity")
        }
    ));
    return resultList;
  }

  @override
  bool get wantKeepAlive => true;

}
