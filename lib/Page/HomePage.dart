import 'package:flutter/material.dart';
import 'package:flutter_weather/Widget/HomePage/BasePager.dart';
import 'package:flutter_weather/Widget/HomePage/CityPager.dart';
import 'package:flutter_weather/Widget/HomePage/WeatherPager.dart';
import 'package:flutter_weather/Bean/City.dart';
import 'package:flutter_weather/Bean/HomePage/CityWeather.dart';
import 'package:flutter_weather/Widget/HomePage/PagerIndicator.dart';
import 'package:flutter_weather/Widget/HomePage/CityPager.dart';

class HomePage extends StatefulWidget {

  List<BasePager> _pagerList = [];
  int index = 0;

  @override
  _HomePageState createState(){
    _initPagerList();
    _pagerList.add(CityPager(_pagerList));
    _pagerList.add(WeatherPager(citySearchKeyword: "shenzhen",));
    _pagerList.add(WeatherPager(citySearchKeyword: "luoding",));
    _pagerList.add(WeatherPager(citySearchKeyword: "chongqing",));
    _pagerList.add(WeatherPager(citySearchKeyword: "hongkong",));
    _pagerList.add(WeatherPager(citySearchKeyword: "newyork",));
    return _HomePageState();
  }

  void _initPagerList(){
    if(_pagerList != null){
      _pagerList = [];
    }else{
      _pagerList.clear();
    }
    index = 0;
  }

}

class _HomePageState extends State<HomePage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            PageView(
              children: _getPager(),
              onPageChanged: _onPageChange,
            ),
            PagerIndicator(widget.index, widget._pagerList),
          ],
        )
    );
  }

  List<BasePager> _getPager(){
    List<BasePager> resultList = [];
    for(BasePager pager in widget._pagerList){
      resultList.add(pager);
    }
    return resultList;
  }

  void _onPageChange(int index){
    setState(() {
      widget.index = index;
    });
  }
}
