import 'package:flutter/material.dart';
import 'package:flutter_weather/Bean/CityWeather.dart';
import 'package:flutter_weather/Widget/HomePage/Card/CityCityCard.dart';
import 'package:flutter_weather/Widget/HomePage/BasePager.dart';
import 'package:flutter_weather/Widget/HomePage/WeatherPager.dart';
import 'package:flutter_weather/Page/SearchPage.dart';
import 'package:flutter_weather/Utils/UISizeUtils.dart';

class CityPager extends BasePager{

  List<BasePager> _cityWeatherList;
  void Function(CityWeather, int) onCityClick;

  CityPager(this._cityWeatherList, this.onCityClick){
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
    return CityPagerState(onCityClick);
  }

}

class CityPagerState extends State<CityPager>  with AutomaticKeepAliveClientMixin{
  void Function(CityWeather, int) onCityClick;
  List<WeatherPager> _tmpWeatherPagerList = [];

  CityPagerState(this.onCityClick);

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
    for(int i=0; i<_tmpWeatherPagerList.length; i++){
      WeatherPager weatherPager = _tmpWeatherPagerList[i];
      resultList.add(CityCityCard(
          weatherPager.cityWeather.city,
          weatherPager.citySearchKeyword,
          onTap: () => {
            _onCityClick(weatherPager.cityWeather, i)
          }
      ));
    }
    // 添加城市 卡片
    resultList.add(CityCityCard.addCityCard(
        onTap: () => _onAddCityClick()
    ));
    return resultList;
  }

  void _onCityClick(CityWeather pager, int index){
    onCityClick(pager, index);
  }

  void _onAddCityClick(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
  }

  @override
  bool get wantKeepAlive => true;

}
