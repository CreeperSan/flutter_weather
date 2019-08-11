import 'package:flutter/material.dart';
import 'package:flutter_weather/Widget/HomePage/BasePager.dart';
import 'package:flutter_weather/Widget/HomePage/CityPager.dart';
import 'package:flutter_weather/Widget/HomePage/WeatherPager.dart';
import 'package:flutter_weather/Bean/City.dart';
import 'package:flutter_weather/Bean/CityWeather.dart';
import 'package:flutter_weather/Widget/HomePage/PagerIndicator.dart';
import 'package:flutter_weather/Widget/HomePage/CityPager.dart';
import 'package:flutter_weather/Utils/UISizeUtils.dart';
import 'package:flutter_weather/Manager/CacheManager.dart';
import 'package:flutter_weather/Global/GlobalData.dart';

class HomePage extends StatefulWidget {

  GlobalData globalData = GlobalData.getInstance();
  _HomePageState state = _HomePageState();

  List<BasePager> _pagerList = [];
  int index = 0;

  @override
  _HomePageState createState(){
    _initPagerList();
    return state;
  }

  void _initPagerList(){
    // 初始化数据
    if(_pagerList != null){
      _pagerList = [];
    }else{
      _pagerList.clear();
    }
    index = 0;
    // 加载数据
    CityPager cityPager = CityPager(state.onCityClick);
    _pagerList.add(cityPager);
    List<CityWeather> cityList = globalData.getCityWeatherList();
    cityList.forEach((city)=>{
      _pagerList.add(WeatherPager.fromCityID(city.city.cid))
    });
  }

}

class _HomePageState extends State<HomePage>{
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              width: UISizeUtils.getWindowWidth(context),
              height: UISizeUtils.getWindowHeight(context),
              color: Colors.purple,
            ),
            Positioned(
              top: UISizeUtils.getStatusBarHeight(context),
              child: Container(
                width: UISizeUtils.getWindowWidth(context),
                height: UISizeUtils.getContentHeight(context),
                child: PageView(
                  controller: pageController,
                  children: _getPager(),
                  onPageChanged: _onPageChange,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top,
              left: 0.0,
              right: 0.0,
              child: Container(
                height: PagerIndicator.HEIGHT,
                child: Align(
                  child: PagerIndicator(widget.index, widget._pagerList),
                ),
              ),
            ),
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

  void onCityClick(CityWeather cityWeather, int index){
    pageController.animateToPage(index+1,
      duration: Duration(
        milliseconds: 300
      ),
      curve: Interval(
        0,
        1.0,
        curve: Curves.fastOutSlowIn
      )
    );
  }
}
